#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

print "Merging trace files\n";

my @traces;

foreach my $trace_file (glob("static-*-[0-9]*-trace.txt")) {
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

my $merged_trace_file = "static-" . time() . "-merged-trace.txt";

my $cmd = "lcov $lcov_param -o $merged_trace_file";

print "Writing merge to: $merged_trace_file\n";
print "Executing: $cmd\n";

system($cmd);

#EOF

