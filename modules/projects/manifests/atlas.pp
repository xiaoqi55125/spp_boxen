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

  $home = "/Users/${::luser}"

  exec { "bundle install --local":
    cwd => "${::boxen_srcdir}/atlas",
    require => Repository["${::boxen_srcdir}/atlas"],
  }

  file { "${home}/.pow/atlas":
    target  => "${::boxen_srcdir}/atlas",
    ensure  => "link",
    require => Package["pow"]
  }

}