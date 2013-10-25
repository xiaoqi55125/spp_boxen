class config::dash {

  file { "Dash Preferences":
    path    => "/Users/${::boxen_user}/Library/Preferences/com.kapeli.dash.plist",
    source  => "puppet:///modules/spp/com.kapeli.dash.plist",
    require => Package['Dash'],
  }

  $base = "/Users/${::boxen_user}/Library/Application Support"
  $dash_dir = "${base}/Dash"
  $docsets_dir = "${dash_dir}/DocSets"

  $structure = [$dash_dir, $docsets_dir]

  file { $structure:
    ensure  => 'directory',
    owner   => "${::boxen_user}",
    mode    => '0755',
  }
}
