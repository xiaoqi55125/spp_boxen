class spp::config {

  include config::sublime

  file { "iTerm2 Preferences":
      path => "/Users/${::luser}/Library/Preferences/com.googlecode.iterm2.plist",
      source  => "puppet:///modules/spp/com.googlecode.iterm2.plist",
  }

  exec {"Add colour to git output":
    command => "git config --global color.ui true",
    require => Package['boxen/brews/git'],
  }

  exec {"Disable Gatekeeper":
    command => "spctl --master-disable",
    user => "root", # Needs to be sudo 'cause it returns successfully and does nothing without it
  }

}