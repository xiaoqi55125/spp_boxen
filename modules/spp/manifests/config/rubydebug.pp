class config::rubydebug {

  file { "/Users/${::luser}/.rdebugrc":
    ensure  => link,
    target  => 'puppet:///modules/spp/rdebugrc',
    mode    => '0755',
  }

}
