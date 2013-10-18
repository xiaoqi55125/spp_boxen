
# see: https://gist.github.com/erikh/2260182
# see: https://gist.github.com/jfryman/4963514

class config::osx {

  # OSX Defaults
  #
  # Before adding something here, see if the boxen-osx module already defines
  # something you can reuse. See shared/osx/README.md

  ::boxen::osx_defaults { 'Secure Empty Trash':
    key    => 'EmptyTrashSecurely',
    domain => 'com.apple.finder',
    value  => 'true',
  }

  ::boxen::osx_defaults { 'Always use current directory in default search':
    key    => 'FXDefaultSearchScope',
    domain => 'com.apple.finder',
    value  => 'SCcf',
  }

  ::boxen::osx_defaults { 'Do not create .DS_Store':
    key    => 'DSDontWriteNetworkStores',
    domain => 'com.apple.dashboard',
    value  => 'true',
  }

  ::boxen::osx_defaults { 'Disable the "Are you sure you want to open this application?" dialog':
    key    => 'LSQuarantine',
    domain => 'com.apple.LaunchServices',
    value  => 'true',
  }

  ::boxen::osx_defaults { 'Expand save panel by default':
    key    => 'NSNavPanelExpandedStateForSaveMode',
    domain => 'NSGlobalDomain',
    value  => 'true',
  }

  ::boxen::osx_defaults { 'Expand print panel by default':
    key    => 'PMPrintingExpandedStateForPrint',
    domain => 'NSGlobalDomain',
    value  => 'true',
  }

  ::boxen::osx_defaults { "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)":
    key    => 'AppleKeyboardUIMode',
    domain => 'NSGlobalDomain',
    value  => '3',
  }

  ::boxen::osx_defaults { "Show Path bar in Finder":
    key    => 'ShowPathbar',
    domain => 'com.apple.finder',
    value  => 'true',
  }

  include ::osx::dock::autohide

  ::boxen::osx_defaults { "Show Status bar in Finder":
    key    => 'ShowStatusBar',
    domain => 'com.apple.finder',
    value  => 'true',
  }

  ::boxen::osx_defaults { "Display full POSIX path as Finder window title":
    key    => '_FXShowPosixPathInTitle',
    domain => 'com.apple.finder',
    value  => 'true',
  }

  # This overrides boxen::security by reversing the setting.
  # TODO: find a better way to do this (e.g., don't run boxen::security)
  ::boxen::osx_defaults { 'do not require password at screensaver':
    ensure => present,
    domain => 'com.apple.screensaver',
    key    => 'askForPassword',
    value  => 0,
    user   => $::boxen_user
  }

  class { '::osx::global::natural_mouse_scrolling':
    enabled => false
  }

  exec { "Show the ~/Library folder":
    command => "chflags nohidden ~/Library",
    onlyif => "ls -dlaO ~/Library | grep hidden",
  }

}

