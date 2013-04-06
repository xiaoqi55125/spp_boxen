class projects::atlas {

  include phantomjs
  include postgresql
  include java
  include postgis

  boxen::project { 'atlas':
    postgresql    => true,
    ruby          => '1.9.3',
    source        => 'lonelyplanet/atlas'
  }

  file { "/Users/${::luser}/.pow/atlas":
    target  => "${::boxen_srcdir}/atlas",
    ensure  => "link",
    require => Package["pow"]
  }

}
