#!/usr/bin/perl

@grades = split /\n/, << 'GRADES';
A   15  4.00
A-  14  3.67
B+  12  3.33
B   11  3.00
B-  10  2.67
C+   8  2.33
C    7  2.00
C-   6  1.67
D+   4  1.33
D    3  1.00
D-   2  0.67
GRADES

$_ = [split /\s+/] for @grades;
$grades{$_->[0]} = { fas=>$_->[1], std=>$_->[2] } for @grades;

while (<>)
{
    chomp;
    next if /^\s*(#|$)/;
    my ( $course, $title, $grade, $type ) = split /\t+/;
    next if $grade eq 'pass';
    $_{overall}{courses}++;
    $_{overall}{std_total} += $grades{$grade}{std};
    $_{overall}{fas_total} += $grades{$grade}{fas};
    $_{$type}{courses}++;
    $_{$type}{std_total} += $grades{$grade}{std};
    $_{$type}{fas_total} += $grades{$grade}{fas};
    my $subtype = lc $course;
    $subtype =~ s/\s.*//;
    $_{$subtype}{courses}++;
    $_{$subtype}{std_total} += $grades{$grade}{std};
    $_{$subtype}{fas_total} += $grades{$grade}{fas};
}

$_->{std_average} = 1.0*$_->{std_total}/$_->{courses} for values %_;
$_->{fas_average} = 1.0*$_->{fas_total}/$_->{courses} for values %_;

for ( sort {
    $_{$b}{courses} <=> $_{$a}{courses} or $a cmp $b
} keys %_ )
{
	print	"\U$_\E\n";
	printf	"     courses: %2d\n", $_{$_}{courses};
	printf	" std average: %5.2f\n", $_{$_}{std_average};
	printf	" fas average: %5.2f\n", $_{$_}{fas_average};
	print	"\n";
}

