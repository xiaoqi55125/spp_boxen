class config::dock {

  property_list_key { "Remove items kept in dock":
    ensure => absent,
    path   => "/Users/${::luser}/Library/Preferences/com.apple.dock.plist",
    key    => 'persistent-apps',
  }->

  property_list_key { "Remove link to documents/downloads":
    ensure => absent,
    path   => "/Users/${::luser}/Library/Preferences/com.apple.dock.plist",
    key    => 'persistent-others'
  }->

  exec { "killall -HUP Dock":
    provider => 'shell',
    path     => "/usr/bin"
 }
}
