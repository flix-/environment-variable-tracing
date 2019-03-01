#!/usr/bin/perl

use strict;
use warnings;

# BEGIN CONFIG #

my $token_prefix = '%__IFDSENVIRONMENTVARIABLETRACING_DUMMY_BEFORE_RET__';
my $instruction = 'urem i4711 4711, 4711';

# END CONFIG #

die "Usage: $0 <path_to_ir_in> <path_to_ir_out>\n" if @ARGV != 2;

my $ir_file_in = shift(@ARGV);
my $ir_file_out = shift(@ARGV);

open(my $ir_file_in_fh, '<', $ir_file_in) or die "Cannot open $ir_file_in for reading\n";
open(my $ir_file_out_fh, '>', $ir_file_out) or die "Cannot open $ir_file_out for writing\n";

my $index = 0;

while (my $line = <$ir_file_in_fh>) {
    chomp($line);

    if ($line =~ m/^(\s+)ret\s.*/) {
        print $ir_file_out_fh "${1}${token_prefix}${index} = ${instruction}\n";
        $index++;
    }
    print $ir_file_out_fh "$line\n";
}

close($ir_file_in_fh);
close($ir_file_out_fh);

#EOF

