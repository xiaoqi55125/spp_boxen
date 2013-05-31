class projects::remixer {

  include postgresql

  boxen::project { 'remixer':
    postgresql    => true,
    ruby          => '1.9.3-p392',
    source        => 'lonelyplanet/remixer'
  }

  file { "${::boxen_srcdir}/atlas/public/remixer":
    target  => "${::boxen_srcdir}/remixer/public",
    ensure  => "link"
  }

}
