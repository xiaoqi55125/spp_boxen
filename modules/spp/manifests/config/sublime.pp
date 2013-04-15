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
    content  => '
[
  { "keys": ["super+ctrl+r"], "command": "reveal_in_side_bar"},
  { "keys": ["alt+down"], "command": "move", "args": {"by": "stops", "empty_line": true, "forward": true} },
  { "keys": ["alt+up"], "command": "move", "args": {"by": "stops", "empty_line": true, "forward": false} },
  { "keys": ["alt+shift+down"], "command": "expand_selection_forward_paragraph" },
  { "keys": ["alt+shift+up"], "command": "expand_selection_backward_paragraph" }
]',
    require => Package['SublimeText2'],
  }

  file { "${base}/Sublime Text 2/Packages/User/Preferences.sublime-settings":
    content  => '
{
  "color_scheme": "Packages/Color Scheme - Default/Solarized (Light).tmTheme",
  "trim_trailing_white_space_on_save": true,
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "ensure_newline_at_eof_on_save": true,
  "folder_exclude_patterns": [".svn", ".git", ".hg", "CVS", ".tmp", ".librarian", "public/assets", "public/spec"],
  "hot_exit": false,
  "remember_open_files": false,

  // Set the Cucumber bundle to left-align cells
  "table_cleaner_align_to_middle": false,

  "highlight_line": true
}',
    require => Package['SublimeText2'],
  }

  file { "${base}/Sublime Text 2/Settings/License.sublime_license":
    content  => '
----- BEGIN LICENSE -----
Lonely Planet
7 User License
EA7E-858309
777C587E C6504149 9E5CBF29 38777BB7
B128FE3D 816F6992 A0D1D22C D9DA7B7C
0A357A52 4F8B710B E339EC83 9068FF1E
7A562351 373F308D 4F1C9537 1AF5CD0C
D935E6A6 7857A68B E7A8D567 B607B59D
631CE139 7AA0D408 92B8AAD0 6C61B457
9612A75E 153A8023 55CF5716 61B1D2CD
2DCC6FE2 9AA8D07F 273E2800 9824BE8E
------ END LICENSE ------
',
    require => Package['SublimeText2'],
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
    "lonelyplanet/AtlasTestRunner"
    ]:
  }

}
