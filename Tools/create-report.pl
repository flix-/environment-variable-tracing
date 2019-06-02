#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Clone 'clone';

# BEGIN CONFIG #

my $report_file = "report-" . time() . ".txt";
my $diff_trace_file = "diff-" . time() . "-trace.txt";
my $diff_retval_trace_file = "diff-retval-" . time() . "-trace.txt";

my $summary_only = 1;

# END CONFIG #

die "Usage: $0 <path_to_static_trace> <path_to_static_ret_trace> <path_to_dynamic_trace> [<path_to_filter_file>]\n" if (@ARGV != 3 && @ARGV != 4);

my $static_trace_file = shift @ARGV;
my $ret_trace_file = shift @ARGV;
my $dynamic_trace_file = shift @ARGV;
my $filter_file = shift @ARGV;

my $filters = get_filters_from_file($filter_file);

my $static_trace = get_trace_from_file($static_trace_file);
my $dynamic_trace = get_trace_from_file($dynamic_trace_file);
my $dynamic_hit_trace = create_hit_trace($dynamic_trace);
my $diff_trace = create_diff_trace($static_trace, $dynamic_hit_trace);
my $diff_hit_trace = create_hit_trace($diff_trace);
my $ret_trace = get_trace_from_file($ret_trace_file);
my $ret_total_trace = get_ret_totals_from_dynamic_file($dynamic_trace_file);
my $ret_test_diff_trace = create_diff_trace($ret_trace, $dynamic_hit_trace);
my $ret_test_diff_hit_trace = create_hit_trace($ret_test_diff_trace);

#print Dumper $filters;

#print Dumper $static_trace;
#print Dumper $dynamic_trace;
#print Dumper $dynamic_hit_trace;
#print Dumper $diff_trace;
#print Dumper $diff_hit_trace;
#print Dumper $ret_trace;
#print Dumper $ret_total_trace;
#print Dumper $ret_test_diff_trace;
#print Dumper $ret_test_diff_hit_trace;

print "Writing report to: $report_file\n";

write_report($static_trace,
             $dynamic_trace,
             $dynamic_hit_trace,
             $diff_hit_trace,
             $ret_trace,
             $ret_total_trace,
             $ret_test_diff_hit_trace,
             $report_file);

print "Writing diff to: $diff_trace_file\n";
write_trace($diff_trace, $diff_trace_file);

print "Writing retval diff to: $diff_retval_trace_file\n";
write_trace($ret_test_diff_trace, $diff_retval_trace_file);

sub get_filters_from_file {
    my $filter_file = shift;

    return undef if (!$filter_file);

    open(my $filter_fh, '<', $filter_file) or die "Cannot open $filter_file for reading\n";

    my $filters = {};

    while (my $line = <$filter_fh>) {
        chomp($line);
        next if ($line =~ m/^\s*$/);

        $filters->{$line} = 1;
    }

    close($filter_fh);

    return $filters;
}

sub get_trace_from_file {
    my $trace_file = shift;

    open(my $trace_fh, '<', $trace_file) or die "Cannot open $trace_file for reading\n";

    my $trace = {};

    my $current_file;
    while (my $line = <$trace_fh>) {
        chomp($line);

        if ($line =~ m/SF:(.*)/) {
            $current_file = $1;
            next;
        }

        next if (!$current_file);

        if ($filters && !$filters->{$current_file}) {
            #print "Skipping: $current_file\n";
            next;
        }
        
        $trace->{$current_file} = undef unless (exists ${trace}->{$current_file});

        if ($line =~ m/FNDA:([0-9]+),(.*)/) {
            my $function_count = $1;
            my $function_name = $2;

            if (exists $trace->{$current_file}->{"FNDA"}->{$function_name}) {
                my $new_count = $trace->{$current_file}->{"FNDA"}->{$function_name} > $function_count ?
                                        $trace->{$current_file}->{"FNDA"}->{$function_name} :
                                        $function_count;

                $trace->{$current_file}->{"FNDA"}->{$function_name} = $new_count;
            } else {
                $trace->{$current_file}->{"FNDA"}->{$function_name} = $function_count;
            }
        }
        elsif ($line =~ m/DA:([0-9]+),([0-9]+)/) {
            my $loc = $1;
            my $loc_count = $2;

            if (exists $trace->{$current_file}->{"DA"}->{$loc}) {
                my $new_count = $trace->{$current_file}->{"DA"}->{$loc} > $loc_count ?
                                        $trace->{$current_file}->{"DA"}->{$loc} :
                                        $loc_count;

                $trace->{$current_file}->{"DA"}->{$loc} = $new_count;
            } else {
                $trace->{$current_file}->{"DA"}->{$loc} = $loc_count;
            }
        }
    }

    close($trace_fh);

    return $trace;
}

sub create_hit_trace {
    my $trace = clone(shift);

    foreach my $file (keys %{$trace}) {
        foreach my $function (keys %{$trace->{$file}->{"FNDA"}}) {
            my $has_hit = $trace->{$file}->{"FNDA"}->{$function} > 0;

            delete $trace->{$file}->{"FNDA"}->{$function} unless $has_hit;
        }
        delete $trace->{$file}->{"FNDA"} unless keys %{$trace->{$file}->{"FNDA"}};

        foreach my $loc (keys %{$trace->{$file}->{"DA"}}) {
            my $has_hit = $trace->{$file}->{"DA"}->{$loc} > 0;

            delete $trace->{$file}->{"DA"}->{$loc} unless $has_hit;
        }
        delete $trace->{$file}->{"DA"} unless keys %{$trace->{$file}->{"DA"}};

        delete $trace->{$file} unless keys %{$trace->{$file}};
    }

    return $trace;
}

sub create_diff_trace {
    my $static_trace = clone(shift);
    my $dynamic_hit_trace = shift;

    foreach my $static_file (keys %{$static_trace}) {
        foreach my $static_function (keys %{$static_trace->{$static_file}->{"FNDA"}}) {
            $static_trace->{$static_file}->{"FNDA"}->{$static_function} = 0;
        }
        foreach my $static_loc (keys %{$static_trace->{$static_file}->{"DA"}}) {
            $static_trace->{$static_file}->{"DA"}->{$static_loc} = 0;
        }
    }

    foreach my $dynamic_hit_file (keys %{$dynamic_hit_trace}) {
        next unless exists($static_trace->{$dynamic_hit_file});

        foreach my $dynamic_hit_function (keys %{$dynamic_hit_trace->{$dynamic_hit_file}->{"FNDA"}}) {
            my $is_function_hit = exists($static_trace->{$dynamic_hit_file}->{"FNDA"}->{$dynamic_hit_function});

            $static_trace->{$dynamic_hit_file}->{"FNDA"}->{$dynamic_hit_function} = 1 if $is_function_hit;
        }
        foreach my $dynamic_hit_loc (keys %{$dynamic_hit_trace->{$dynamic_hit_file}->{"DA"}}) {
            my $is_loc_hit = exists($static_trace->{$dynamic_hit_file}->{"DA"}->{$dynamic_hit_loc});

            $static_trace->{$dynamic_hit_file}->{"DA"}->{$dynamic_hit_loc} = 1 if $is_loc_hit;
        }
    }

    return $static_trace;
}

sub get_ret_totals_from_dynamic_file {
    my $dynamic_trace_file = shift;

    open(my $dynamic_trace_fh, '<', $dynamic_trace_file) or die "Cannot open $dynamic_trace_file for reading\n";

    my $fn_loc_map = {};

    my $current_file;
    while (my $line = <$dynamic_trace_fh>) {
        chomp($line);

        if ($line =~ m/SF:(.*)/) {
            $current_file = $1;
            next;
        }

        next if (!$current_file);

        if ($filters && !$filters->{$current_file}) {
            #print "Skipping: $current_file\n";
            next;
        }

        $fn_loc_map->{$current_file} = undef unless (exists ${fn_loc_map}->{$current_file});

        if ($line =~ m/FN:([0-9]+),(.*)/) {
            my $function_start_loc = $1;
            my $function_name = $2;

            $fn_loc_map->{$current_file}->{$function_start_loc} = $function_name;
        }
    }

    close($dynamic_trace_fh);

    my $trace = {};

    foreach my $file (keys %{$fn_loc_map}) {
        open(my $file_fh, '<', $file) or die "Cannot open $file for reading\n";

        for (my $loc = 1; my $line = <$file_fh>; $loc++) {
            chomp($line);

            next if $line =~ m/\*.*return/;
            next if $line =~ m/#\s*define/;
            next if $line =~ m/".*return.*"/;
            next if $line =~ m/\(.*return.*\)/;
            next if $line =~ m/\S+\s*return\s+/;

            if ($line =~ m/\s+return\s+/) {
                my $candidate = 0;
                foreach my $function_start_loc (sort {$a <=> $b} keys %{$fn_loc_map->{$file}}) {
                    if ($loc >= $function_start_loc) {
                        $candidate = $function_start_loc;
                        next;
                    }
                    last if $candidate;
                }
                my $function = $fn_loc_map->{$file}->{$candidate};

                if ($function) {
                    $trace->{$file}->{"FNDA"}->{$function} = '1';
                    $trace->{$file}->{"DA"}->{$loc} = '1';
                }
            }
        }

        close($file_fh);
    }

    return $trace;
}

sub get_total_files_from_trace {
    my $trace = shift;

    return keys %{$trace};
}

sub get_total_functions_from_trace {
    my $trace = shift;

    my $total_functions = 0;
    foreach my $file (keys %{$trace}) {
        foreach my $function (keys %{$trace->{$file}->{"FNDA"}}) {
            $total_functions++;
        }
    }

    return $total_functions;
}

sub get_total_loc_from_trace {
    my $trace = shift;

    my $total_loc = 0;
    foreach my $file (keys %{$trace}) {
        foreach my $loc (keys %{$trace->{$file}->{"DA"}}) {
            $total_loc++;
        }
    }

    return $total_loc;
}

sub write_report {
    my $static_trace = shift;
    my $dynamic_trace = shift;
    my $dynamic_hit_trace = shift;
    my $diff_hit_trace = shift;
    my $ret_trace = shift;
    my $ret_total_trace = shift;
    my $ret_test_diff_hit_trace = shift;
    my $report_file = shift;

    open(my $report_fh, '>', $report_file) or die "Cannot open $report_file for writing\n";

    print $report_fh "#"x80 . "\n";
    print $report_fh "Total\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($dynamic_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Dependent on Environment Variables\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($static_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Covered by Tests\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($dynamic_hit_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Dependent on Environment Variables and covered by Tests\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($diff_hit_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Total Return Values\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($ret_total_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Return Values dependent on Environment Variables\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($ret_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Return Values dependent on Environment Variables and covered by Tests\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($ret_test_diff_hit_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Ratios\n";
    print $report_fh "#"x80 . "\n\n";

    append_ratios($static_trace,
                  $dynamic_trace,
                  $diff_hit_trace,
                  $ret_trace,
                  $ret_total_trace,
                  $ret_test_diff_hit_trace,
                  $report_fh);

    close($report_fh);
}

sub append_block {
    my $trace = shift;
    my $report_fh = shift;

    print $report_fh "=====\n" unless $summary_only;
    print $report_fh "Files\n" unless $summary_only;
    print $report_fh "=====\n\n" unless $summary_only;

    foreach my $file (sort keys %{$trace}) {
        print $report_fh "$file\n" unless $summary_only;
    }

    print $report_fh "\n" unless $summary_only;

    print $report_fh "=========\n" unless $summary_only;
    print $report_fh "Functions\n" unless $summary_only;
    print $report_fh "=========\n\n" unless $summary_only;

    foreach my $file (sort keys %{$trace}) {
        print $report_fh "$file\n" unless $summary_only;

        foreach my $function (sort keys %{$trace->{$file}->{"FNDA"}}) {
            print $report_fh "$function\n" unless $summary_only;
        }

        print $report_fh "\n" unless $summary_only;
    }

    print $report_fh "===\n" unless $summary_only;
    print $report_fh "LOC\n" unless $summary_only;
    print $report_fh "===\n\n" unless $summary_only;

    foreach my $file (sort keys %{$trace}) {
        print $report_fh "$file\n" unless $summary_only;

        foreach my $loc (sort {$a <=> $b} keys %{$trace->{$file}->{"DA"}}) {
            print $report_fh "$loc\n" unless $summary_only;
        }

        print $report_fh "\n" unless $summary_only;
    }

    print $report_fh "=======\n";
    print $report_fh "Summary\n";
    print $report_fh "=======\n\n";

    my $total_files = get_total_files_from_trace($trace);
    my $total_functions = get_total_functions_from_trace($trace);
    my $total_loc = get_total_loc_from_trace($trace);

    printf $report_fh "Total files: %u\n", $total_files;
    printf $report_fh "Total functions: %u\n", $total_functions;
    printf $report_fh "Total LOC: %u\n", $total_loc;

    print $report_fh "\n";
}

sub append_ratios {
    my $static_trace = shift;
    my $dynamic_trace = shift;
    my $diff_hit_trace = shift;
    my $ret_trace = shift;
    my $ret_total_trace = shift;
    my $ret_test_diff_hit_trace = shift;
    my $report_fh = shift;

    my $total_files = get_total_files_from_trace($dynamic_trace);
    my $total_functions = get_total_functions_from_trace($dynamic_trace);
    my $total_loc = get_total_loc_from_trace($dynamic_trace);

    my $static_files = get_total_files_from_trace($static_trace);
    my $static_functions = get_total_functions_from_trace($static_trace);
    my $static_loc = get_total_loc_from_trace($static_trace);

    my $dep_env_var_files_ratio = $total_files != 0 ? $static_files / $total_files : 0;
    my $dep_env_var_functions_ratio = $total_functions != 0 ? $static_functions / $total_functions : 0;
    my $dep_env_var_loc_ratio = $total_loc != 0 ? $static_loc / $total_loc : 0;

    print $report_fh "==================================\n";
    print $report_fh "Dependent on Environment Variables\n";
    print $report_fh "==================================\n\n";

    printf $report_fh "Files: %.2f%%\n", $dep_env_var_files_ratio * 100;
    printf $report_fh "Functions: %.2f%%\n", $dep_env_var_functions_ratio * 100;
    printf $report_fh "LOC: %.2f%%\n", $dep_env_var_loc_ratio * 100;

    print $report_fh "\n";

    my $diff_hit_files = get_total_files_from_trace($diff_hit_trace);
    my $diff_hit_functions = get_total_functions_from_trace($diff_hit_trace);
    my $diff_hit_loc = get_total_loc_from_trace($diff_hit_trace);

    my $diff_files_ratio = $static_files != 0 ? $diff_hit_files / $static_files : 0;
    my $diff_functions_ratio = $static_functions != 0 ? $diff_hit_functions / $static_functions : 0;
    my $diff_loc_ratio = $static_loc != 0 ? $diff_hit_loc / $static_loc : 0;

    print $report_fh "=======================================================\n";
    print $report_fh "Dependent on Environment Variables and covered by Tests\n";
    print $report_fh "=======================================================\n\n";

    printf $report_fh "Files: %.2f%%\n", $diff_files_ratio * 100;
    printf $report_fh "Functions: %.2f%%\n", $diff_functions_ratio * 100;
    printf $report_fh "LOC: %.2f%%\n", $diff_loc_ratio * 100;

    print $report_fh "\n";

    my $total_retval_files = get_total_files_from_trace($ret_total_trace);
    my $total_retval_functions = get_total_functions_from_trace($ret_total_trace);
    my $total_retval_loc = get_total_loc_from_trace($ret_total_trace);

    my $dep_env_var_retval_files = get_total_files_from_trace($ret_trace);
    my $dep_env_var_retval_functions = get_total_functions_from_trace($ret_trace);
    my $dep_env_var_retval_loc = get_total_loc_from_trace($ret_trace);

    my $retval_files_ratio = $total_retval_files != 0 ? $dep_env_var_retval_files / $total_retval_files : 0;
    my $retval_functions_ratio = $total_retval_functions != 0 ? $dep_env_var_retval_functions / $total_retval_functions : 0;
    my $retval_loc_ratio = $total_retval_loc != 0 ? $dep_env_var_retval_loc / $total_retval_loc : 0;

    print $report_fh "================================================\n";
    print $report_fh "Return Values dependent on Environment Variables\n";
    print $report_fh "================================================\n\n";

    printf $report_fh "Files: %.2f%%\n", $retval_files_ratio * 100;
    printf $report_fh "Functions: %.2f%%\n", $retval_functions_ratio * 100;
    printf $report_fh "LOC: %.2f%%\n", $retval_loc_ratio * 100;

    print $report_fh "\n";

    my $diff_hit_retval_files = get_total_files_from_trace($ret_test_diff_hit_trace);
    my $diff_hit_retval_functions = get_total_functions_from_trace($ret_test_diff_hit_trace);
    my $diff_hit_retval_loc = get_total_loc_from_trace($ret_test_diff_hit_trace);

    my $diff_retval_files_ratio = $dep_env_var_retval_files != 0 ? $diff_hit_retval_files / $dep_env_var_retval_files : 0;
    my $diff_retval_functions_ratio = $dep_env_var_retval_functions != 0 ? $diff_hit_retval_functions / $dep_env_var_retval_functions : 0;
    my $diff_retval_loc_ratio = $dep_env_var_retval_loc != 0 ? $diff_hit_retval_loc / $dep_env_var_retval_loc : 0;

    print $report_fh "=====================================================================\n";
    print $report_fh "Return Values dependent on Environment Variables and covered by Tests\n";
    print $report_fh "=====================================================================\n\n";

    printf $report_fh "Files: %.2f%%\n", $diff_retval_files_ratio * 100;
    printf $report_fh "Functions: %.2f%%\n", $diff_retval_functions_ratio * 100;
    printf $report_fh "LOC: %.2f%%\n", $diff_retval_loc_ratio * 100;

    print $report_fh "\n";
}

sub write_trace {
    my $trace = shift;
    my $trace_file = shift;

    open(my $trace_fh, '>', $trace_file) or die "Cannot open $trace_file for writing\n";

    foreach my $file (sort keys %{$trace}) {
        printf $trace_fh "SF:%s\n", $file;

        foreach my $function (sort keys %{$trace->{$file}->{"FNDA"}}) {
            my $function_hit = $trace->{$file}->{"FNDA"}->{$function};

            printf $trace_fh "FNDA:%u,%s\n", $function_hit, $function;
        }

        foreach my $loc (sort {$a <=> $b} keys %{$trace->{$file}->{"DA"}}) {
            my $loc_hit = $trace->{$file}->{"DA"}->{$loc};

            printf $trace_fh "DA:%s,%u\n", $loc, $loc_hit;
        }

        printf $trace_fh "end_of_record\n";
    }

    close($trace_fh);
}

#EOF

