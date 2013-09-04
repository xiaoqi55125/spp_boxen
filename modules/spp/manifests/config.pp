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
    path    => "/Users/${::luser}/Library/Preferences/com.googlecode.iterm2.plist",
    source  => "puppet:///modules/spp/com.googlecode.iterm2.plist",
    require => Package['iTerm'],
  }

  file { "Terminal Preferences":
    path   => "/Users/${::luser}/Library/Preferences/com.apple.Terminal.plist",
    source => "puppet:///modules/spp/com.apple.Terminal.plist",
  }

  file { "pgAdmin Preferences":
    path   => "/Users/${::luser}/Library/Preferences/pgadmin3 Preferences",
    source => "puppet:///modules/spp/pgadmin3 Preferences",
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

  $xcodeDir     = "/Applications/Xcode.app"
  $toolchainDir = "${xcodeDir}/Contents/Developer/Toolchains"

  exec { "OSX10.8.xctoolchain symlink":
    # Various homebrew recipes assume the existence of this symlink
    # apparently changed in recent versions of XCode
    command => "ln -s ${toolchainDir}/OSX10.8.xctoolchain ${toolchainDir}/OSX10.8.xctoolchain",
    onlyif  => "ls -l ${toolchainDir} | grep -c Toolchains"
  }

  # ensure xcode-select, regardless of whether we've installed Xcode or command-line tools

  exec { "xcode-select /usr/bin":
    # Without this `gem install libv8` fails and so does brew install node
    # https://github.com/mxcl/homebrew/issues/13337#issuecomment-6925743
    command => "xcode-select -switch /usr/bin",
    unless  => "ls -l /Applications | grep -ic Xcode",
    user    => "root"
  }

  exec { "xcode-select XCode.app":
    command => "xcode-select -switch /usr/bin",
    onlyif  => "ls -l /Applications | grep -ic Xcode",
    user    => "root"
  }

  exec { "dont ask for password after screensaver starts":
    command => "defaults write com.apple.screensaver askForPassword -int 0",
  }
}
