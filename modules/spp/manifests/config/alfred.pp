class config::alfred {

  exec {"Set keyboard shortcut":
    command => "defaults write com.runningwithcrayons.Alfred-Preferences \"hotkey.default\" '{ key = 49; mod = 1048576 ; string = Space; }'",
    user => "root"
  }

}
