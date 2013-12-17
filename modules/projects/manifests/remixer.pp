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

  include xquartz

  package { "freetype":
    ensure => installed
  }

  package { "fontconfig":
    ensure => installed,
    require => Package['freetype']
  }

  package { "ghostscript":
    ensure => installed,
    require => Package['fontconfig']
  }

  package { "imagemagick":
    ensure => installed
  }

}
