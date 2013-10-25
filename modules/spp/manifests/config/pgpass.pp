class config::pgpass {

  file { 'dotfile of postgres passwords':
    mode    => '0600',
    path    => "/Users/${::boxen_user}/.pgpass",
    source  => "${::boxen_srcdir}/pairing_station/licenses/pgpass.license",
  }
}
