#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

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
#my $PHASAR_BIN = '/home/sebastian/documents/programming/llvm/jail/llvm501/bin/phasar';
my $PHASAR_BIN = '/home/sebastian/documents/programming/llvm/jail/llvm501/bin/phasar-debug';
my $PLUGIN = '/home/sebastian/.qt-creator-workspace/build-Phasar-Desktop-Debug/IFDSEnvironmentVariableTracing/libIFDSEnvironmentVariableTracing.so';
# END CONFIG

die "Usage: $0 <path_to_llvm_ir> <path_to_functions>\n" if (@ARGV != 1 && @ARGV != 2);

my $ir_file = shift(@ARGV);
my $functions_file = shift(@ARGV);

open(my $ir_fh, '<', $ir_file) or die "Cannot open file '$ir_file'\n";

my $create_function_list = !$functions_file;
if ($create_function_list) {
    print "Creating function list\n";

    my %functions = getFunctionsFromIR($ir_fh);
    printFunctionsToFile(\%functions, $FUNCTIONS_FILE);

    close($ir_fh);
    exit;
}

print "Running analysis\n";

open(my $funs_fh, '<', $functions_file) or die "Cannot open file '$functions_file'\n";

while (my $function = <$funs_fh>) {
    chomp($function);

    my $file_out = "${function}-" . time() . "-out.txt";

    print "Analyzing function: $function -> $file_out\n";

    system("$PHASAR_BIN -m $ir_file -M 0 -D plugin --analysis-plugin $PLUGIN -E $function > $file_out 2>&1");
}

close($funs_fh);
close($ir_fh);

print "Merging trace files\n";

my @traces;

foreach my $trace_file (glob("static-*-trace.txt")) {
    print "Procesing $trace_file: ";
    if (-z $trace_file) {
        print "Skipping\n";
        next;
    }
    print "Adding\n";

    push @traces, $trace_file;
}

print "No valid trace files found\n" and exit if (!@traces);

my $lcov_param = "";

foreach my $trace_file (@traces) {
    $lcov_param .=  "-a $trace_file ";
}

my $merged_trace_file = "static-${ir_file}-trace.txt";

system("lcov $lcov_param -o $merged_trace_file");

print "Creating HTML page\n";

system("genhtml -o html $merged_trace_file");

