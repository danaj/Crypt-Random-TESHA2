package Crypt::Random::TESHA2::Config;
use strict;
use warnings;

BEGIN {
  $Crypt::Random::TESHA2::Config::AUTHORITY = 'cpan:DANAJ';
  $Crypt::Random::TESHA2::Config::VERSION = '0.01';
}

# Don't just export the variable, because an evil script could change it.

# DO NOT MANUALLY ALTER THE FOLLOWING LINE: configured in Makefile.PL
# The value should be '1.00' in the distribution.
my $_entropy_per_byte = 1.00;

sub entropy { return $_entropy_per_byte; }

1;

__END__

=pod

=head1 NAME

Crypt::Random::TESHA2::Config - Configuration data

=cut
