class spp::config {

  include config::sublime

  file { "iTerm2 Preferences":
      path => "/Users/${::luser}/Library/Preferences/com.googlecode.iterm2.plist",
      source  => "puppet:///modules/spp/com.googlecode.iterm2.plist",
  }

  exec {"git config --global color.ui true":
    require => Package['boxen/brews/git']
  }

}