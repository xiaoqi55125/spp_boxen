class spp::config {

  include config::sublime
  include config::postgis
  include config::pgpass
  include config::git
  include config::shift_it
  include config::dock
  include config::source_tree
  include config::osx
  include config::hosts
  include config::repositories
  include config::rubydebug

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

  # Without this `gem install libv8` fails and so does brew install node (required by pow)
  exec { "Fix Xcode command line issue": # https://github.com/mxcl/homebrew/issues/13337
    command => "xcode-select -switch /usr/bin",
    unless => "xcode-select --print-path | grep -c /usr/bin",
    user => "root"
  }

  # These boxen symlinks (node,node-waf,npm) break when invoking coffee from a SublimeText plugin.
  # Instead, we've hard-coded our PATH to include /opt/boxen/nvm/v0.8.8/bin.
  exec { "Boxen node symlink":
    command => "rm /opt/boxen/bin/node",
    require => Class[nvm]
  }

  exec { "Boxen node-waf symlink":
    command => "rm /opt/boxen/bin/node-waf",
    require => Class[nvm]
  }

  exec { "Boxen npm symlink":
    command => "rm /opt/boxen/bin/npm",
    require => Class[nvm]
  }
}
