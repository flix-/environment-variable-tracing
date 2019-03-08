#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

# START CONFIG

my $PHASAR_BIN = '/home/sebastian/documents/programming/llvm/jail/llvm501-release/bin/phasar';
my $PLUGIN = '/home/sebastian/.qt-creator-workspace/build-Phasar-Desktop-Release/IFDSEnvironmentVariableTracing/libIFDSEnvironmentVariableTracing.so';

my $BULK_MODE = 1;

my $STACK_SIZE_KB = 'unlimited'; #512*1024;

# END CONFIG

die "Usage: $0 <path_to_llvm_ir> <path_to_functions> [<path_to_function_blacklist>]\n" if (@ARGV != 1 && @ARGV != 2 && @ARGV != 3);

my $ir_file = shift @ARGV;
my $functions_file = shift @ARGV;
my $function_blacklist_file = shift @ARGV;

open(my $ir_fh, '<', $ir_file) or die "Cannot open file '$ir_file'\n";

my $create_function_list = !$functions_file;
if ($create_function_list) {
    my %functions = get_functions_from_ir($ir_fh);

    my $functions_out = "functions-" . time() . ".txt";

    printf "Writing functions to: %s\n", $functions_out;

    write_functions_to_file(\%functions, $functions_out);

    close($ir_fh);
    exit;
}

my @entry_points;

open(my $funs_fh, '<', $functions_file) or die "Cannot open file '$functions_file'\n";
while (my $function = <$funs_fh>) {
    chomp($function);

    push @entry_points, $function;
}
close($funs_fh);
close($ir_fh);

die "Function list is empty!\n" unless(@entry_points);

print "Running analysis\n";

print "\n";

printf "Bulk mode: %u\n", $BULK_MODE;
printf "Function blacklist file: %s\n", $function_blacklist_file ? $function_blacklist_file : "none";

print "\n";

$ENV{'FUNCTION_BLACKLIST_LOCATION'} = $function_blacklist_file if $function_blacklist_file;

if ($BULK_MODE) {
    my $analysis_out = "${functions_file}-" . time() . "-out.txt";

    my $entry_points_bulk = "";
    foreach my $entry_point (@entry_points) {
        $entry_points_bulk .= "$entry_point ";
    }

    my $cmd = "ulimit -s $STACK_SIZE_KB && $PHASAR_BIN -m $ir_file -M 0 -D plugin --analysis-plugin $PLUGIN -E $entry_points_bulk > $analysis_out 2>&1";

    printf "Executing: %s\n", $cmd;

    system($cmd);
}
else {
    foreach my $entry_point (@entry_points) {
        my $analysis_out = "${entry_point}-" . time() . "-out.txt";

        my $cmd = "ulimit -s $STACK_SIZE_KB && $PHASAR_BIN -m $ir_file -M 0 -D plugin --analysis-plugin $PLUGIN -E $entry_point > $analysis_out 2>&1";

        printf "Executing: %s\n", $cmd;

        system($cmd);
    }
}

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

#EOF

