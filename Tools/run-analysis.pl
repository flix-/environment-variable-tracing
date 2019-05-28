#!/usr/bin/perl

use strict;
use warnings;

# BEGIN CONFIG

my $PHASAR_BIN = '/home/sebastian/documents/programming/llvm/jail/llvm501-release/bin/phasar';
my $PLUGIN = '/home/sebastian/.qt-creator-workspace/build-Phasar-Desktop-Release/IFDSEnvironmentVariableTracing/libIFDSEnvironmentVariableTracing.so';

my $BULK_MODE = 1;
my $BUFFER_OUTPUT = 0;

my $STACK_SIZE_KB = 'unlimited'; #512*1024;

# END CONFIG

die "Usage: $0 <path_to_llvm_ir> [<path_to_entry_points> [<path_to_tainted_functions>] [<path_to_blacklisted_functions>]]\n" if (@ARGV == 0 || @ARGV > 4);

my $ir_file = shift @ARGV;
my $entry_points_file = shift @ARGV;
my $tainted_functions_file = shift @ARGV;
my $blacklisted_functions_file = shift @ARGV;

if (!$entry_points_file) {
    open(my $ir_fh, '<', $ir_file) or die "Cannot open file '$ir_file'\n";

    my $entry_points = get_entry_points_from_ir($ir_fh);
    my $entry_points_out = "entry-points-" . time() . ".txt";

    printf "Writing entry points to: %s\n", $entry_points_out;

    write_entry_points_to_file($entry_points, $entry_points_out);

    close($ir_fh);
    exit;
}

my @entry_points;

open(my $entry_points_fh, '<', $entry_points_file) or die "Cannot open file '$entry_points_file'\n";
while (my $entry_point = <$entry_points_fh>) {
    chomp($entry_point);

    push @entry_points, $entry_point;
}
close($entry_points_fh);

die "Entry points list is empty!\n" unless(@entry_points);

print "Running analysis\n";

print "\n";

printf "Bulk mode: %u\n", $BULK_MODE;
printf "Buffer output: %u\n", $BUFFER_OUTPUT;
printf "Tainted functions file: %s\n", $tainted_functions_file ? $tainted_functions_file : "none";
printf "Blacklisted functions file: %s\n", $blacklisted_functions_file ? $blacklisted_functions_file : "none";

print "\n";

$ENV{'TAINTED_FUNCTIONS_LOCATION'} = $tainted_functions_file if $tainted_functions_file;
$ENV{'BLACKLISTED_FUNCTIONS_LOCATION'} = $blacklisted_functions_file if $blacklisted_functions_file;

my $buffer_cmd = $BUFFER_OUTPUT ? "" : "stdbuf -oL -eL";

if ($BULK_MODE) {
    my $analysis_out = "${entry_points_file}-" . time() . "-out.txt";

    my $entry_points_bulk = "";
    foreach my $entry_point (@entry_points) {
        $entry_points_bulk .= "$entry_point ";
    }

    my $cmd = "ulimit -s $STACK_SIZE_KB && $buffer_cmd $PHASAR_BIN -m $ir_file -M 0 -D plugin --analysis-plugin $PLUGIN -E $entry_points_bulk > $analysis_out 2>&1";

    printf "Executing: %s\n", $cmd;

    system($cmd);
}
else {
    foreach my $entry_point (@entry_points) {
        my $analysis_out = "${entry_point}-" . time() . "-out.txt";

        my $cmd = "ulimit -s $STACK_SIZE_KB && $buffer_cmd $PHASAR_BIN -m $ir_file -M 0 -D plugin --analysis-plugin $PLUGIN -E $entry_point > $analysis_out 2>&1";

        printf "Executing: %s\n", $cmd;

        system($cmd);
    }
}

sub get_entry_points_from_ir {
    my $ir_fh = shift;

    my $entry_points = { };

    while (my $line = <$ir_fh>) {
        if ($line =~ m/define (?!private|internal).*?@(.*?)\(/) {
            my $entry_point = $1;

            $entry_points->{$entry_point} = undef;
        }
    }

    return $entry_points;
}

sub write_entry_points_to_file {
    my $entry_points = shift;
    my $entry_points_file = shift;

    open(my $entry_points_fh, '>', $entry_points_file) or die "Cannot open $entry_points_file for writing\n";
    
    foreach my $entry_point (keys %{$entry_points}) {
        print $entry_points_fh "$entry_point\n";
    }

    close($entry_points_fh);
}

#EOF

