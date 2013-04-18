class config::sublime {

  define addpkg {
    $packagedir = "/Library/Application Support/Sublime Text 2/Packages/"
    $pkgarray = split($name, '[/]')
    $pkgname = $pkgarray[1]

    exec { "git clone https://github.com/${name}.git":
      cwd      => "/Users/${::luser}${packagedir}",
      provider => 'shell',
      creates  => "/Users/${::luser}${packagedir}${pkgname}",
      path     => "${boxen::config::homebrewdir}/bin",
      require  => [Package['SublimeText2'], Package['boxen/brews/git']],
    }
  }

  $base = "/Users/${::luser}/Library/Application Support"
  $structure = [ "${base}/Sublime Text 2",
                 "${base}/Sublime Text 2/Settings",
                 "${base}/Sublime Text 2/Packages",
                 "${base}/Sublime Text 2/Packages/User"
               ]

  file { $structure:
    ensure  => 'directory',
    owner   => "${::luser}",
    mode    => '0755',
  }->

  file { "${boxen::config::bindir}/subl":
    ensure  => link,
    target  => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl',
    mode    => '0755',
    require => Package['SublimeText2'],
  }->

  file { "${base}/Sublime Text 2/Packages/User/Default (OSX).sublime-keymap":
    source  => "puppet:///modules/spp/Default (OSX).sublime-keymap",
    require => Package['SublimeText2'],
  }

  file { "${base}/Sublime Text 2/Packages/User/Preferences.sublime-settings":
    source  => "puppet:///modules/spp/Preferences.sublime-settings",
    require => Package['SublimeText2'],
  }

  file { "${base}/Sublime Text 2/Settings/License.sublime_license":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/licenses/License.sublime_license",
    require => [Package['SublimeText2'], Repository["${::boxen_srcdir}/pairing_station"]],
  }

  addpkg { [
    "jisaacks/GitGutter",
    "surjikal/sublime-coffee-compile",
    "jashkenas/coffee-script-tmbundle",
    "revolunet/sublimetext-markdown-preview",
    "SublimeColors/Solarized",
    "wbond/sublime_package_control",
    "eklein/sublime-text-puppet",
    "drewda/cucumber-sublime2-bundle",
    "natew/ExpandSelectionByParagraph",
    "kemayo/sublime-text-2-git",
    "dzhibas/SublimePrettyJson",
    "lonelyplanet/AtlasTestRunner",
    "NaN1488/sublime-gem-browser"
    ]:
  }

}
