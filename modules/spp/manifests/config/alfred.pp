class config::alfred {

  $licenseDir = "/Users/${::luser}/Library/Application Support/Alfred 2"
  file { $licenseDir:
    ensure  => 'directory',
    owner   => "${::luser}",
    mode    => '0755',
  }

  file { "Alfred License":
    path    => "/Users/${::luser}/Library/Application Support/Alfred 2/license.plist",
    source  => "puppet:///modules/spp/alfred.license.plist",
    require => [Package['Alfred'], File[$licenseDir]],
  }

  file { "Alfred Preferences":
    path    => "/Users/${::luser}/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist",
    source  => "puppet:///modules/spp/com.runningwithcrayons.Alfred-Preferences.plist",
    require => Package['Alfred'],
  }

  file { "Alfred Preferences2":
    path    => "/Users/${::luser}/Library/Preferences/com.runningwithcrayons.Alfred-2.plist",
    source  => "puppet:///modules/spp/com.runningwithcrayons.Alfred-2.plist",
    require => Package['Alfred'],
  }
}


