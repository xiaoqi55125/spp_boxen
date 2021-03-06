class people::mriddle::repositories {

  define add_dotfile ($dotfile = $title) {
    file { "/Users/${::luser}/.${dotfile}":
      ensure  => link,
      mode    => '0644',
      target  => "${::boxen_srcdir}/dotfiles/${dotfile}",
      require => Repository["${::boxen_srcdir}/dotfiles"],
    }
  }

  repository { "${::boxen_srcdir}/dotfiles":
    source => 'mriddle/dotfiles',
  }

  repository { "${::boxen_srcdir}/pairing_station":
    source => 'lonelyplanet/pairing_station',
  }

  repository { "${::boxen_srcdir}/private_dotfiles":
    source => 'mriddle/private_dotfiles',
  }

  add_dotfile {'ackrc': }
  add_dotfile {'bash_aliases': }
  add_dotfile {'bash_profile': }
  add_dotfile {'bashrc': }
  add_dotfile {'inputrc': }

  repository { "${::boxen_srcdir}/notes_bin":
    source => 'mriddle/notes_bin',
  }

  repository { "${::boxen_srcdir}/epubifier":
    source => 'mriddle/epubifier',
  }

  repository { "${::boxen_srcdir}/dabblet":
    source => 'mriddle/dabblet',
  }

  repository { "${::boxen_srcdir}/websockets_chat":
    source => 'mriddle/websockets_chat',
  }

  repository { "${::boxen_srcdir}/mriddle_blog":
    source => 'mriddle/blog',
  }

  file { "/Users/${::luser}/.work_env":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/private_dotfiles/work_env",
    require => Repository["${::boxen_srcdir}/private_dotfiles"],
  }

}



