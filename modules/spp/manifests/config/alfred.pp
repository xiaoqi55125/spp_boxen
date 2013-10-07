class config::alfred {

  file { "Alfred Preferences":
    path    => "/Users/${::luser}/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist",
    source  => "puppet:///modules/spp/com.runningwithcrayons.Alfred-Preferences.plist",
    require => Package['Alfred'],
  }

}
