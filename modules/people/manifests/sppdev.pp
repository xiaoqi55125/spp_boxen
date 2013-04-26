class people::sppdev {

  include spp::environment

  repository { "${::boxen_srcdir}/pairing_station":
    source => 'lonelyplanet/pairing_station',
  }

  define add_dotfile ($dotfile = $title) {
    file { "/Users/${::luser}/.${dotfile}":
      ensure  => link,
      mode    => '0644',
      target  => "${::boxen_srcdir}/pairing_station/${dotfile}",
      require => Repository["${::boxen_srcdir}/pairing_station"],
    }
  }

  add_dotfile {'bashrc': }
  add_dotfile {'bash_aliases': }
  add_dotfile {'bash_profile': }
  add_dotfile {'inputrc': }

  file { "/Users/${::luser}/.ssh/id_rsa":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/ssh_pairing_station",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  file { "/Users/${::luser}/.ssh/id_rsa.pub":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/ssh_pairing_station.pub",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  file { "/Users/${::luser}/.ssh/config":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/ssh_config",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

}
