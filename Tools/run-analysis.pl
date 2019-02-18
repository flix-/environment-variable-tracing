#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

sub get_functions_from_ir {
    my $ir_fh = shift;

    my %functions;

    while (my $line = <$ir_fh>) {
        if ($line =~ m/define (?!private|internal).*?@(.*?)\(/g) {
            $functions{$1} = undef;
        }
    }

    return %functions;
}

sub write_functions_to_file {
    my $functions = shift;
    my $functions_file = shift;

    open(my $fun_fh, '>', $functions_file) or die "Cannot open $functions_file for writing\n";
    
    foreach my $function (keys %{$functions}) {
        print $fun_fh "$function\n";
    }

    close($fun_fh);
}

# START CONFIG

my $PHASAR_BIN = '/home/sebastian/documents/programming/llvm/jail/llvm501-release/bin/phasar';
my $PLUGIN = '/home/sebastian/.qt-creator-workspace/build-Phasar-Desktop-Release/IFDSEnvironmentVariableTracing/libIFDSEnvironmentVariableTracing.so';

my $STACK_SIZE_KB = 'unlimited'; #512*1024;

# END CONFIG

die "Usage: $0 <path_to_llvm_ir> <path_to_functions>\n" if (@ARGV != 1 && @ARGV != 2);

my $ir_file = shift(@ARGV);
my $functions_file = shift(@ARGV);

open(my $ir_fh, '<', $ir_file) or die "Cannot open file '$ir_file'\n";

my $create_function_list = !$functions_file;
if ($create_function_list) {
    my %functions = get_functions_from_ir($ir_fh);

    my $functions_out = "functions-" . time() . ".txt";

    print "Writing functions to: $functions_out\n";
    write_functions_to_file(\%functions, $functions_out);

    close($ir_fh);
    exit;
}

print "Running analysis\n";

my $analysis_out = "${functions_file}-" . time() . "-out.txt";
my $entry_points = "";

open(my $funs_fh, '<', $functions_file) or die "Cannot open file '$functions_file'\n";
while (my $function = <$funs_fh>) {
    chomp($function);

    $entry_points .= "$function ";
}
close($funs_fh);
close($ir_fh);

print "Entry points: $entry_points\n";
print "Writing analysis to: $analysis_out\n";
print "Stack size (kbyte): $STACK_SIZE_KB\n";

system("ulimit -s $STACK_SIZE_KB && $PHASAR_BIN -m $ir_file -M 0 -D plugin --analysis-plugin $PLUGIN -E $entry_points > $analysis_out 2>&1");

