class config::dock {

  file { "Dock Preferences":
    path => "/Users/${::luser}/Library/Preferences/com.apple.dock.plist",
    source  => "puppet:///modules/spp/com.apple.dock.plist",
  }

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
