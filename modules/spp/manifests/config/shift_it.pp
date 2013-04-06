class config::shift_it {

  property_list_key { "Enable auto update":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/org.shiftitapp.ShiftIt.plist",
    key    => 'SUEnableAutomaticChecks',
    value  => true,
    value_type => 'boolean',
  }

  property_list_key { "Has launched before":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/org.shiftitapp.ShiftIt.plist",
    key    => 'SUHasLaunchedBefore',
    value  => true,
    value_type => 'boolean',
  }

  property_list_key { "Has started before":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/org.shiftitapp.ShiftIt.plist",
    key    => 'hasStartedBefore',
    value  => true,
    value_type => 'boolean',
  }

  property_list_key { "Enable full screen shortcut - Keycode":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/org.shiftitapp.ShiftIt.plist",
    key    => 'fullscreenKeyCode',
    value  => 36,
    value_type => 'integer',
  }

  property_list_key { "Enable full screen shortcut - Modifiers":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/org.shiftitapp.ShiftIt.plist",
    key    => 'fullscreenModifiers',
    value  => 1835008,
    value_type => 'integer',
  }

}
