#!/usr/bin/perl

use strict;
use warnings;

sub getFunctionsFromIR {
    my $ir_fh = shift;

    my %functions;

    while (my $line = <$ir_fh>) {
        if ($line =~ m/define (?!private|internal).*?@(.*?)\(/g) {
            $functions{$1} = undef;
        }
    }

    return %functions;
}

sub printFunctionsToFile {
    my $functions = shift;
    my $functions_file = shift;

    open(my $fun_fh, '>', $functions_file) or die "Cannot open $functions_file for writing\n";
    
    foreach my $function (keys %{$functions}) {
        print $fun_fh "$function\n";
    }

    close($fun_fh);
}

# START CONFIG
my $FUNCTIONS_FILE = 'functions.txt';
my $PHASAR_BIN = '/home/sebastian/documents/programming/llvm/jail/llvm501/bin/phasar';
my $PLUGIN = '/home/sebastian/.qt-creator-workspace/build-Phasar-Desktop-Debug/IFDSEnvironmentVariableTracing/libIFDSEnvironmentVariableTracing.so';
# END CONFIG

die "Usage: $0 <path_to_llvm_ir> <path_to_functions>\n" if (@ARGV != 1 && @ARGV != 2);

my $ir_file = shift(@ARGV);
my $functions_file = shift(@ARGV);

open(my $ir_fh, '<', $ir_file) or die "Cannot open file '$ir_file'\n";

my $create_function_list = !$functions_file;
if ($create_function_list) {
    my %functions = getFunctionsFromIR($ir_fh);
    printFunctionsToFile(\%functions, $FUNCTIONS_FILE);

    close($ir_fh);
    exit;
}

open(my $funs_fh, '<', $functions_file) or die "Cannot open file '$functions_file'\n";

while (my $function = <$funs_fh>) {
    chomp($function);
    print "Analyzing function: $function\n";

    system("$PHASAR_BIN -m $ir_file -M 0 -D plugin --analysis-plugin $PLUGIN -E $function > ${function}-out.txt 2>&1");
}

close($funs_fh);
close($ir_fh);

