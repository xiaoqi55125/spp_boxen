class config::sublime {

  define addpkg {
    $packagedir = "/Library/Application Support/Sublime Text 2/Packages/"
    $pkgarray = split($name, '[/]')
    $pkgname = $pkgarray[1]

    exec { "git clone https://github.com/${name}.git":
      cwd      => "/Users/${::boxen_user}${packagedir}",
      provider => 'shell',
      creates  => "/Users/${::boxen_user}${packagedir}${pkgname}",
      path     => "${::boxen::config::homebrewdir}/bin",
      require  => [Package['SublimeText2'], Package['boxen/brews/git']],
    }
  }

  $base = "/Users/${::boxen_user}/Library/Application Support"
  $structure = [ "${base}/Sublime Text 2",
                 "${base}/Sublime Text 2/Settings",
                 "${base}/Sublime Text 2/Packages",
                 "${base}/Sublime Text 2/Packages/User"
               ]

  file { $structure:
    ensure  => 'directory',
    owner   => "${::boxen_user}",
    mode    => '0755',
  }->

  file { "${::boxen::config::bindir}/subl":
    ensure  => link,
    target  => '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl',
    mode    => '0755',
    require => Package['SublimeText2'],
  }

  $installedPackagesDir = "${base}/Sublime Text 2/Installed Packages"
  file { $installedPackagesDir:
    ensure  => "${installedPackagesDir}",
    owner   => "${::boxen_user}",
    mode    => '0755',
  }

  $packageControlLink = "https://sublime.wbond.net/Package%20Control.sublime-package"
  exec { "curl -o 'Package Control.sublime-package' ${packageControlLink}":
    cwd      => "${installedPackagesDir}",
    provider => 'shell',
    creates  => "${installedPackagesDir}/Package Control.sublime-package",
    path     => "/usr/bin",
    require  => [Package['SublimeText2'], File[$installedPackagesDir]],
  }

  exec { "git clone https://github.com/${name}.git":
    cwd      => "/Users/${::boxen_user}${packagedir}",
    provider => 'shell',
    creates  => "/Users/${::boxen_user}${packagedir}${pkgname}",
    path     => "${::boxen::config::homebrewdir}/bin",
    require  => [Package['SublimeText2'], Package['boxen/brews/git']],
  }

  file { "${base}/Sublime Text 2/Packages/User/Default (OSX).sublime-keymap":
    source  => "puppet:///modules/spp/sublime_text/Default (OSX).sublime-keymap",
    require => Package['SublimeText2'],
  }

  file { "${base}/Sublime Text 2/Packages/User/Preferences.sublime-settings":
    source  => "puppet:///modules/spp/sublime_text/Preferences.sublime-settings",
    require => Package['SublimeText2'],
  }

  file { "${base}/Sublime Text 2/Packages/User/Shell-Unix-Generic.sublime-settings":
    source  => "puppet:///modules/spp/sublime_text/Shell-Unix-Generic.sublime-settings",
    require => Package['SublimeText2'],
  }

  file { "${base}/Sublime Text 2/Packages/User/Ruby.sublime-settings":
    source  => "puppet:///modules/spp/sublime_text/Ruby.sublime-settings",
    require => Package['SublimeText2'],
  }

  addpkg { [
    "jisaacks/GitGutter",
    "surjikal/sublime-coffee-compile",
    "Xavura/CoffeeScript-Sublime-Plugin",
    "revolunet/sublimetext-markdown-preview",
    "SublimeColors/Solarized",
    "eklein/sublime-text-puppet",
    "drewda/cucumber-sublime2-bundle",
    "natew/ExpandSelectionByParagraph",
    "kemayo/sublime-text-2-git",
    "dzhibas/SublimePrettyJson",
    "lonelyplanet/AtlasTestRunner",
    "NaN1488/sublime-gem-browser",
    "Monnoroch/ColorHighlighter",
    "facelessuser/BracketHighlighter",
    "Dimillian/Sublime-Hacker-News-Reader",
    "CraigWilliams/BeautifyRuby",
    "irohiroki/RubyBlockConverter",
    "iltempo/sublime-text-2-hash-syntax",
    ]:
  }

  file { "/Users/${::boxen_user}/Library/Fonts":
    ensure  => 'directory',
    owner   => "${::boxen_user}",
    mode    => '0700',
  }->

  file { "/Users/${::boxen_user}/Library/Fonts/Inconsolata.otf":
    mode    => '0644',
    source  => "puppet:///modules/spp/Inconsolata.otf",
  }

}
