class spp::config {

  include config::sublime
  include config::postgis
  include config::git
  include config::shift_it
  include config::dock

  file { "iTerm2 Preferences":
    path => "/Users/${::luser}/Library/Preferences/com.googlecode.iterm2.plist",
    source  => "puppet:///modules/spp/com.googlecode.iterm2.plist",
    require => Package['iTerm'],
  }

  exec {"Disable Gatekeeper":
    command => "spctl --master-disable",
    unless => "spctl --status | grep -c disabled",
    user => "root", # Needs to be sudo 'cause it returns successfully and does nothing without it
  }

  file { "Enable Accessibility API":
    path => "/private/var/db/.AccessibilityAPIEnabled",
    content => "a",
    mode => "444",
    owner => "root"
  }

  exec { "Enable ssh access":
    command => "systemsetup -setremotelogin on",
    unless => "systemsetup -getremotelogin | grep -c On",
  }

  property_list_key { 'Show GitX where git lives':
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/nl.frim.GitX.plist",
    key    => 'gitExecutable',
    value  => '/opt/boxen/homebrew/bin/git',
  }

  property_list_key { "Disable the 'Are you sure you want to open this application?' dialog":
    ensure => present,
    path   => "/Users/${::luser}/Library/Preferences/com.apple.LaunchServices.plist",
    key    => 'LSQuarantine',
    value  => false,
    value_type => 'boolean',
  }

  osx_login_item { 'Quicksilver':
    name => 'Quicksilver',
    path => '/Applications/Quicksilver.app',
    hidden => true,
    require => Package['Quicksilver'],
  }

  osx_login_item { 'ShiftIt':
    name => 'ShiftIt',
    path => '/Applications/ShiftIt.app',
    hidden => true,
    require => Package['ShiftIt'],
  }

}
