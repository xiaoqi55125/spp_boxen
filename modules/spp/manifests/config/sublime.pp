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
  $structure = [ "${base}/Sublime Text 2", "${base}/Sublime Text 2/Packages", "${base}/Sublime Text 2/Packages/User"]

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

  // Set the Cucumber bundle to left-align cells
  "table_cleaner_align_to_middle": false
}',
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
    ]:
  }

}
