class spp::config {

  include config::sublime
  include config::postgis
  include config::git

  file { "iTerm2 Preferences":
    path => "/Users/${::luser}/Library/Preferences/com.googlecode.iterm2.plist",
    source  => "puppet:///modules/spp/com.googlecode.iterm2.plist",
    require => Package['iTerm'],
  }

  exec {"Disable Gatekeeper":
    command => "spctl --master-disable",
    user => "root", # Needs to be sudo 'cause it returns successfully and does nothing without it
  }

  file { "ShiftIt Preferences":
    path => "/Users/${::luser}/Library/Preferences/org.shiftitapp.ShiftIt.plist",
    source  => "puppet:///modules/spp/org.shiftitapp.ShiftIt.plist",
  }

  file { "Enable Accessibility API":
    path => "/private/var/db/.AccessibilityAPIEnabled",
    content => "a",
    mode => "444",
    owner => "root"
  }

  file { "Dock Preferences":
    path => "/Users/${::luser}/Library/Preferences/com.apple.dock.plist",
    source  => "puppet:///modules/spp/com.apple.dock.plist",
  }

  file { "Disable the 'Are you sure you want to open this application?' dialog":
    path => "/Users/${::luser}/Library/Preferences/com.apple.LaunchServices.plist",
    source  => "puppet:///modules/spp/com.apple.LaunchServices.plist",
  }

  exec { "Enable ssh access":
    command => "systemsetup -setremotelogin on",
  }

  file { "GitX Preferences":
    path => "/Users/${::luser}/Library/Preferences/nl.frim.GitX.plist",
    source => "puppet:///modules/spp/nl.frim.GitX.plist",
  }

}
