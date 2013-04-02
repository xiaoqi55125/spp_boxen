class config::git {
  exec {"Add colour to git output":
    command => "git config --global color.ui true",
    require => Package['boxen/brews/git'],
  }

  exec {"Set push.default to simple":
    command => "git config --global push.default simple",
    require => Package['boxen/brews/git'],
  }
}
