class people::mriddle {
  include minecraft

  include spp::applications
  include spp::config
  include projects::atlas

  repository { "${::boxen_srcdir}/dotfiles":
    source => 'mriddle/dotfiles',
  }

  define add_dotfile ($dotfile = $title) {
    file { "/Users/${::luser}/.${dotfile}":
      ensure  => link,
      mode    => '0644',
      target  => "${::boxen_srcdir}/dotfiles/${dotfile}",
      require => Repository["${::boxen_srcdir}/dotfiles"],
    }
  }

  add_dotfile {'ackrc': }
  add_dotfile {'bash_aliases': }
  add_dotfile {'bash_profile': }
  add_dotfile {'bashrc': }

}
