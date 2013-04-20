class projects::remixer {

  include postgresql

  boxen::project { 'remixer':
    postgresql    => true,
    ruby          => '1.9.3-p392',
    source        => 'lonelyplanet/remixer'
  }

  file { "/Users/${::luser}/.pow/remixer":
    target  => "${::boxen_srcdir}/remixer",
    ensure  => "link",
    require => Package["pow"]
  }

}
