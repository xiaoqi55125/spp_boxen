class people::mriddle::config {

  git::config::global{ 'user.name':
    value => 'Matthew Riddle',
  }

  git::config::global{ 'user.email':
    value => 'mriddle89@gmail.com',
  }

  git::config::global { 'alias.lg':
    value => "log --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cr%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph --date-order",
  }

  file { "/Users/${::luser}/.id_rsa":
    ensure  => link,
    mode    => '0600',
    target  => "${::boxen_srcdir}/private_dotfiles/ssh_private_key",
    require => Repository["${::boxen_srcdir}/private_dotfiles"],
  }

  file { "/Users/${::luser}/.id_rsa.pub":
    ensure  => link,
    mode    => '0600',
    target  => "${::boxen_srcdir}/private_dotfiles/ssh_public_key",
    require => Repository["${::boxen_srcdir}/private_dotfiles"],
  }

  file { "/Users/${::luser}/Library/Application Support/Sublime Text 2/Settings/License.sublime_license":
    ensure  => link,
    mode    => '0640',
    target  => "${::boxen_srcdir}/private_dotfiles/sublime_text.license",
    require => Repository["${::boxen_srcdir}/private_dotfiles"],
  }

}
