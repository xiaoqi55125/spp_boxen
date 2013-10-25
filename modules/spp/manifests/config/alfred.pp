class config::alfred {

  $licenseDir = "/Users/${::boxen_user}/Library/Application Support/Alfred 2"
  file { $licenseDir:
    ensure  => 'directory',
    owner   => "${::boxen_user}",
    mode    => '0755',
  }

  file { "Alfred License":
    path    => "/Users/${::boxen_user}/Library/Application Support/Alfred 2/license.plist",
    source  => "puppet:///modules/spp/alfred.license.plist",
    require => [Package['Alfred'], File[$licenseDir]],
  }

    file { "Alfred Preferences":
    path    => "/Users/${::boxen_user}/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist",
    source  => "puppet:///modules/spp/com.runningwithcrayons.Alfred-Preferences.plist",
    require => Package['Alfred'],
  }
}
