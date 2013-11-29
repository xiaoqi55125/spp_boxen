class projects::remixer {

  include postgresql

  boxen::project { 'remixer':
    postgresql    => true,
    ruby          => '1.9.3-p484',
    source        => 'lonelyplanet/remixer'
  }

  file { "${::boxen_srcdir}/atlas/public/remixer":
    target  => "${::boxen_srcdir}/remixer/public",
    ensure  => "link"
  }

  # xquartz includes fontconfig, which remixer depends on
  include xquartz

  package { "gs":
    ensure => installed
  }

  package { "imagemagick":
    ensure => installed
  }

}
