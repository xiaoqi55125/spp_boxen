class config::dock {

  property_list_key { "Remove items kept in dock":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/com.apple.dock.plist",
    key    => 'persistent-apps',
    value  => [],
    value_type => 'array',
  }

  property_list_key { "Remove link to documents/downloads":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/com.apple.dock.plist",
    key    => 'persistent-others',
    value  => [],
    value_type => 'array',
  }

}
