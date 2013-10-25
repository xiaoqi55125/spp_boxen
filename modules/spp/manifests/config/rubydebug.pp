class config::rubydebug {

  file { "/Users/${::boxen_user}/.rdebugrc":
    ensure  => link,
    target  => "${::boxen_srcdir}/pairing_station/rdebugrc",
    mode    => '0755',
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

}
