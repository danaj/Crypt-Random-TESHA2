use ExtUtils::MakeMaker;

WriteMakefile1(
    NAME         => 'Crypt::Random::TESHA2',
    ABSTRACT     => "Random numbers using timer/schedule entropy, aka userspace voodoo entropy",
    VERSION_FROM => 'lib/Crypt/Random/TESHA2.pm', # finds $VERSION
    LICENSE      => 'perl',
    AUTHOR       => 'Dana A Jacobsen <dana@acm.org>',

    BUILD_REQUIRES=>{
                      'Test::More'       => '0.45',
                    },
    PREREQ_PM     => {
                       'Exporter'        => '5.562',
                       'Digest::SHA'     => '5.22',
                       'Time::HiRes'     => '1.9711',
                       'base'            => 0,
                       'Carp'            => 0,
                     },

    META_MERGE    => {
                     },
    MIN_PERL_VERSION => 5.006002,
);

sub WriteMakefile1 {   # Cribbed from eumm-upgrade by Alexandr Ciornii
  my %params = @_;
  my $eumm_version = $ExtUtils::MakeMaker::VERSION;
  $eumm_version = eval $eumm_version;

  if ($params{BUILD_REQUIRES} and $eumm_version < 6.5503) {
      #EUMM 6.5502 has problems with BUILD_REQUIRES
      $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
      delete $params{BUILD_REQUIRES};
  }
  delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
  delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
  delete $params{META_MERGE} if $eumm_version < 6.46;
  delete $params{META_ADD} if $eumm_version < 6.46;
  delete $params{LICENSE} if $eumm_version < 6.31;
  delete $params{AUTHOR} if $] < 5.005;
  delete $params{ABSTRACT_FROM} if $] < 5.005;
  delete $params{BINARY_LOCATION} if $] < 5.005;

  WriteMakefile(%params);
}
