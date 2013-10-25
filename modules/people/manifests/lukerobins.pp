class people::lukerobins {

  include spp::environment

  repository { "${::boxen_srcdir}/pairing_station":
    source => 'lonelyplanet/pairing_station',
  }

  define add_dotfile ($dotfile = $title) {
    file { "/Users/${::boxen_user}/.${dotfile}":
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

}
