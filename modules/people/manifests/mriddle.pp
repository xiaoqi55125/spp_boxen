class people::mriddle {
  include minecraft

  $my_home = "/Users/${::luser}"
  $my_sourcedir = $home = "${my_home}/${::srcdir}"

  repository { "${my_sourcedir}/dotfiles":
    source => 'mriddle/dotfiles',
  }

  define add_dotfile ($dotfile = $title) {
    file { "${my_home}/.${dotfile}":
      ensure  => link,
      mode    => '0644',
      target  => "${my_sourcedir}/dotfiles/.${dotfile}",
      require => Repository["${my_sourcedir}/dotfiles"],
    }
  }
  
  add_dotfile {'ackrc': }
  add_dotfile {'bash_aliases': }
  add_dotfile {'bash_profile': }
  add_dotfile {'bashrc': }

  file { "${home}/.bash_profile":
    ensure  => present,
    content => '[[ -f /opt/boxen/env.sh ]] && . /opt/boxen/env.sh'
  }


}