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
    mode    => '0600',
    target  => "${::boxen_srcdir}/pairing_station/ssh_pairing_station",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  exec { ".ssh/id_rsa":
    # we need to set file permisssion on the origin file, not the symlink
    command => "chmod 600 ${::boxen_srcdir}/pairing_station/ssh_pairing_station",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  file { "/Users/${::luser}/.ssh/id_rsa.pub":
    ensure  => link,
    mode    => '0600',
    target  => "${::boxen_srcdir}/pairing_station/ssh_pairing_station.pub",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  file { "/Users/${::luser}/.ssh/authorized_keys":
    ensure  => link,
    mode    => '0600',
    # This is not a copy/paste error: we want to authorize our own pubkey only.
    # It's used by fastj to copy a workspace up to a Jenkins agent.
    target  => "${::boxen_srcdir}/pairing_station/ssh_pairing_station.pub",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  file { "/Users/${::luser}/.ssh/config":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/ssh_config",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  file { "/Users/${::luser}/.vim":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/vim",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }

  file { "/Users/${::luser}/.vimrc":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/vimrc",
    require => Repository["${::boxen_srcdir}/pairing_station"],
  }
}
