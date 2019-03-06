#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Clone 'clone';

# BEGIN CONFIG #

my $diff_trace_file = "diff-" . time() . "-trace.txt";
my $report_file = "report-" . time() . ".txt";

#my $skip_file_pattern = "/home/sebastian/documents/programming/src/openssl-1.1.1a/test";
my $skip_file_pattern = "/home/sebastian/.qt-creator-workspace/Phasar/Sample/src/test";

my $summary_only = 1;

# END CONFIG #

die "Usage: $0 <path_to_static_trace> <path_to_dynamic_trace>\n" if @ARGV != 2;

my $static_trace_file = shift @ARGV;
my $dynamic_trace_file = shift @ARGV;

my $static_trace = get_trace_from_file($static_trace_file);
my $dynamic_trace = get_trace_from_file($dynamic_trace_file);
my $dynamic_hit_trace = create_hit_only_trace($dynamic_trace);
my $static_dynamic_hit_diff_trace = create_diff_trace($static_trace,
                                                      $dynamic_hit_trace,
                                                      $dynamic_trace);

#print Dumper $static_trace;
#print Dumper $dynamic_trace;
#print Dumper $dynamic_hit_trace;
#print Dumper $static_dynamic_hit_diff_trace;

# create / write report
print "Writing report to: $report_file\n";
write_report($static_trace,
             $dynamic_trace,
             $dynamic_hit_trace,
             $static_dynamic_hit_diff_trace,
             $report_file);

# write diff
print "Writing diff to: $diff_trace_file\n";
write_diff($static_dynamic_hit_diff_trace,
           $diff_trace_file);


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

        next if (!$current_file || ($current_file =~ m/$skip_file_pattern/));
        
        $trace->{$current_file} = undef unless (exists ${trace}->{$current_file});

        if ($line =~ m/FN:([0-9]+),(.*)/) {
            my $function_start_loc = $1;
            my $function_name = $2;

            $trace->{$current_file}->{"FN"}->{$function_start_loc} = $function_name;
        }
        elsif ($line =~ m/FNDA:([0-9]+),(.*)/) {
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

sub create_hit_only_trace {
    my $trace = clone(shift);

    foreach my $file (keys %{$trace}) {
        delete $trace->{$file}->{"FN"};

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

sub get_function_from_file_and_loc {
    my $file = shift;
    my $loc = shift;
    my $loc_function_lookup = shift;

    return unless exists($loc_function_lookup->{$file}->{"FN"});

    for (my $i = $loc; $i >= 0; $i--) {
        my $hit = exists($loc_function_lookup->{$file}->{"FN"}->{$i});

        return $loc_function_lookup->{$file}->{"FN"}->{$i} if $hit;
    }
}

sub create_diff_trace {
    my $static_trace = clone(shift);
    my $dynamic_trace = clone(shift);
    my $loc_function_lookup = shift;

    foreach my $static_file (keys %{$static_trace}) {
        delete $static_trace->{$static_file}->{"FN"};
        delete $static_trace->{$static_file}->{"FNDA"};
    }

    foreach my $dynamic_file (keys %{$dynamic_trace}) {
        next unless exists($static_trace->{$dynamic_file});

        foreach my $dynamic_loc (keys %{$dynamic_trace->{$dynamic_file}->{"DA"}}) {
            my $is_loc_hit = exists($static_trace->{$dynamic_file}->{"DA"}->{$dynamic_loc});

            delete $static_trace->{$dynamic_file}->{"DA"}->{$dynamic_loc} if $is_loc_hit;
        }
        delete $static_trace->{$dynamic_file} unless keys %{$static_trace->{$dynamic_file}->{"DA"}};
    }

    foreach my $static_file (keys %{$static_trace}) {
        foreach my $static_loc (keys %{$static_trace->{$static_file}->{"DA"}}) {
            my $function = get_function_from_file_and_loc($static_file,
                                                          $static_loc,
                                                          $loc_function_lookup);
            if (!$function) {
                print "Error: Could not find function for file: $static_file, LOC: $static_loc\n";
                next;
            }

            $static_trace->{$static_file}->{"FNDA"}->{$function} = 1;
        }
    }

    return $static_trace;
}

#sub create_diff_trace {
#    my $static_trace = clone(shift);
#    my $dynamic_trace = shift;
#
#    foreach my $dynamic_file (keys %{$dynamic_trace}) {
#        next unless exists($static_trace->{$dynamic_file});
#
#        foreach my $dynamic_function (keys %{$dynamic_trace->{$dynamic_file}->{"FNDA"}}) {
#            my $is_loc_hit = exists($static_trace->{$dynamic_file}->{"FNDA"}->{$dynamic_function});
#
#            delete $static_trace->{$dynamic_file}->{"FNDA"}->{$dynamic_function} if $is_loc_hit;
#        }
#        delete $static_trace->{$dynamic_file}->{"FNDA"} unless keys %{$static_trace->{$dynamic_file}->{"FNDA"}};
#
#        foreach my $dynamic_loc (keys %{$dynamic_trace->{$dynamic_file}->{"DA"}}) {
#            my $is_loc_hit = exists($static_trace->{$dynamic_file}->{"DA"}->{$dynamic_loc});
#
#            delete $static_trace->{$dynamic_file}->{"DA"}->{$dynamic_loc} if $is_loc_hit;
#        }
#        delete $static_trace->{$dynamic_file}->{"DA"} unless keys %{$static_trace->{$dynamic_file}->{"DA"}};
#
#        delete $static_trace->{$dynamic_file} unless keys %{$static_trace->{$dynamic_file}};
#    }
#
#    return $static_trace;
#}

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
    my $dynamic_hit_only_trace = shift;
    my $static_dynamic_hit_diff_trace = shift;
    my $report_file = shift;

    open(my $report_fh, '>', $report_file) or die "Cannot open $report_file for writing\n";

    print $report_fh "#"x80 . "\n";
    print $report_fh "Dependent on Environment Variables\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($static_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Totals\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($dynamic_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Covered by Unit Tests\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($dynamic_hit_only_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Dependent on Environment Variables but not fully covered by Unit Tests\n";
    print $report_fh "#"x80 . "\n\n";

    append_block($static_dynamic_hit_diff_trace, $report_fh);

    print $report_fh "#"x80 . "\n";
    print $report_fh "Ratios\n";
    print $report_fh "#"x80 . "\n\n";

    append_ratios($static_trace,
                  $dynamic_trace,
                  $static_dynamic_hit_diff_trace,
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

    print $report_fh "Total files: $total_files\n";
    print $report_fh "Total functions: $total_functions\n";
    print $report_fh "Total LOC: $total_loc\n";

    print $report_fh "\n";
}

sub append_ratios {
    my $static_trace = shift;
    my $dynamic_trace = shift;
    my $static_dynamic_hit_diff_trace = shift;
    my $report_fh = shift;

    my $total_files = get_total_files_from_trace($dynamic_trace);
    my $total_functions = get_total_functions_from_trace($dynamic_trace);
    my $total_loc = get_total_loc_from_trace($dynamic_trace);

    my $dependent_env_var_files = get_total_files_from_trace($static_trace);
    my $dependent_env_var_functions = get_total_functions_from_trace($static_trace);
    my $dependent_env_var_loc = get_total_loc_from_trace($static_trace);

    my $dependent_env_var_files_ratio = $dependent_env_var_files / $total_files;
    my $dependent_env_var_functions_ratio = $dependent_env_var_functions / $total_functions;
    my $dependent_env_var_loc_ratio = $dependent_env_var_loc / $total_loc;

    print $report_fh "==================================\n";
    print $report_fh "Dependent on Environment Variables\n";
    print $report_fh "==================================\n\n";

    printf $report_fh "Files: %.2f%%\n", $dependent_env_var_files_ratio * 100;
    printf $report_fh "Functions: %.2f%%\n", $dependent_env_var_functions_ratio * 100;
    printf $report_fh "LOC: %.2f%%\n", $dependent_env_var_loc_ratio * 100;

    print $report_fh "\n";

    my $static_dynamic_hit_diff_files = get_total_files_from_trace($static_dynamic_hit_diff_trace);
    my $static_dynamic_hit_diff_functions = get_total_functions_from_trace($static_dynamic_hit_diff_trace);
    my $static_dynamic_hit_diff_loc = get_total_loc_from_trace($static_dynamic_hit_diff_trace);

    my $static_dynamic_hit_diff_files_ratio = $static_dynamic_hit_diff_files / $dependent_env_var_files;
    my $static_dynamic_hit_diff_functions_ratio = $static_dynamic_hit_diff_functions / $dependent_env_var_functions;
    my $static_dynamic_hit_diff_loc_ratio = $static_dynamic_hit_diff_loc / $dependent_env_var_loc;

    print $report_fh "======================================================================\n";
    print $report_fh "Dependent on Environment Variables but not fully covered by Unit Tests\n";
    print $report_fh "======================================================================\n\n";

    printf $report_fh "Files: %.2f%%\n", $static_dynamic_hit_diff_files_ratio * 100;
    printf $report_fh "Functions: %.2f%%\n", $static_dynamic_hit_diff_functions_ratio * 100;
    printf $report_fh "LOC: %.2f%%\n", $static_dynamic_hit_diff_loc_ratio * 100;

    print $report_fh "\n";
}

sub write_diff {
    my $diff_trace = shift;
    my $diff_trace_file = shift;

    open(my $diff_trace_fh, '>', $diff_trace_file) or die "Cannot open $diff_trace_file for writing\n";

    foreach my $file (keys %{$diff_trace}) {
        print $diff_trace_fh "SF:${file}\n";

        foreach my $function (keys %{$diff_trace->{$file}->{"FNDA"}}) {
            print $diff_trace_fh "FNDA:0,${function}\n";
        }

        foreach my $loc (keys %{$diff_trace->{$file}->{"DA"}}) {
            print $diff_trace_fh "DA:${loc},0\n";
        }

        print $diff_trace_fh "end_of_record\n";
    }

    close($diff_trace_fh);
}

#EOF

