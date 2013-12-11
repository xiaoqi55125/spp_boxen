class config::psqlrc {
  file { "/Users/${::luser}/.psqlrc":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/psqlrc",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }
}
