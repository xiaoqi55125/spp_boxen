class config::dash {

  file { "Dash Preferences":
    path    => "/Users/${::luser}/Library/Preferences/com.kapeli.dash.plist",
    source  => "puppet:///modules/spp/com.kapeli.dash.plist",
    require => Package['Dash'],
  }

  $base = "/Users/${::luser}/Library/Application Support"
  $dash_dir = "${base}/Dash"
  $docsets_dir = "${dash_dir}/DocSets"

  $structure = [$dash_dir, $docsets_dir]

  file { $structure:
    ensure  => 'directory',
    owner   => "${::luser}",
    mode    => '0755',
  }
}
