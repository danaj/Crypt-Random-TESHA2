#!/usr/bin/env perl
use strict;
use warnings;
use Time::HiRes qw/gettimeofday usleep/;
use Digest::SHA qw/sha256/;
use Test::More tests => 1;

my @vars;
foreach my $byte (1..200) {
  my ($start, $t1, $t2) = gettimeofday();
  my $str = pack("LL", $start, $t1);
  my %dummy;
  foreach my $bit (1 .. 8) {
    usleep(2+3*$bit);
    (undef, $t2) = gettimeofday();
    # Note this has nothing to do with the start time or the hash.
    my $diff = $t2 >= $t1 ? $t2-$t1 : $t2-$t1+1000000;
    push @vars, $diff - (2+3*$bit);
    $str .= pack("L", $t1 ^ $t2);
    $dummy{$str . $_}++ for 1..8;
    $t1 = $t2;
  }
}

my($min, $max) = (~0, -1);
#shift @vars;
foreach my $v (@vars) {
  $min = $v if $v < $min;
  $max = $v if $v > $max;
}

my $total = scalar @vars;
diag "$total values collected.  min: $min  max: $max";

# Compute simple entropy H
my %freq;
$freq{$_}++ for @vars;

my $H = 0;
foreach my $f (values %freq) {
  my $p = $f / $total;
  $H += $p * log($p);
}
$H = -$H / log(2);

my $_entropy_per_raw_byte = 6.0;  # parameter from module source
my $bits_per_output = (8*$H) * (8/$_entropy_per_raw_byte);
my $Hstr = sprintf("%.2f", $H);
my $Expstr = sprintf("%.1f", $bits_per_output);

diag "Raw usleep 0-order entopy: $Hstr bits => $Expstr bits per output byte";
cmp_ok($bits_per_output, '>=', 8.0, "Entropy per output byte is at least 8 bits");
