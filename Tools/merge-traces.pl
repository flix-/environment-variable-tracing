#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

print "Merging trace files\n";

my @traces;

foreach my $trace_file (glob("static-[0-9]*-trace.txt")) {
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

my $merged_trace_file = "static-merged-" . time() . "-trace.txt";

system("lcov $lcov_param -o $merged_trace_file");

print "Creating HTML page\n";

system("genhtml -o html $merged_trace_file");

