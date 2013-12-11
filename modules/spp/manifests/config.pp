class spp::config {

  include config::sublime
  include config::pgpass
  include config::psqlrc
  include config::git
  include config::shift_it
  include config::dock
  include config::source_tree
  include config::osx
  include config::hosts
  include config::repositories
  include config::rubydebug
  include config::dash
  include config::alfred

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

  file { "Keyboard shortcut preferences":
    path   => "/Users/${::luser}/Library/Preferences/com.apple.symbolichotkeys.plist",
    source => "puppet:///modules/spp/com.apple.symbolichotkeys.plist",
  }

  exec { "killall SystemUIServer":
    provider => 'shell',
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

  osx_login_item { 'Alfred 2':
    name => 'Alfred 2',
    path => '/Applications/Alfred 2.app',
    hidden => true,
    require => Package['Alfred'],
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
  # without this, any use of gcc will cause 'xcrun: Error: failed to exec real xcrun'
  # first thing to check when native gems fail to compile

  exec { "xcode-select /usr/bin":
    # Without this `gem install libv8` fails and so does brew install node
    # https://github.com/mxcl/homebrew/issues/13337#issuecomment-6925743
    command => "xcode-select -switch /usr/bin",
    unless  => "ls -l /Applications | grep -ic Xcode",
    user    => "root"
  }

  # XCode 4.x
  exec { "xcode-select /Applications/XCode.app":
    command => "xcode-select -switch /Applications/Xcode.app",
    onlyif  => "ls -l /Applications | grep -ic Xcode",
    user    => "root"
  }

  # XCode 5.x
  exec { "xcode-select /Applications/XCode.app/Contents/Developer":
    command => "xcode-select -switch /Applications/Xcode.app/Contents/Developer",
    onlyif  => "ls -l /Applications/Xcode.app/Contents | grep -ic Developer",
    user    => "root"
  }
}
