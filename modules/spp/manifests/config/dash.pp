class config::dash {

  $base = "/Users/${::luser}/Library/Application Support"

  $structure = [ "${base}/Dash" ]
  $docSetsLink = "https://s3-ap-southeast-2.amazonaws.com/spp-boxen/DocSets.zip"
  $dashFileLink = "https://s3-ap-southeast-2.amazonaws.com/spp-boxen/library.dash"

  file { $structure:
    ensure  => 'directory',
    owner   => "${::luser}",
    mode    => '0755',
  }->

  exec { "curl -o library.dash ${dashFileLink}":
    cwd      => "${base}/Dash",
    provider => 'shell',
    creates  => "${base}/Dash/library.dash",
    path     => "/usr/bin",
    require  => Package['Dash'],
  }->

  exec { "curl -o DocSets.zip ${docSetsLink}":
    cwd      => "${base}/Dash",
    provider => 'shell',
    creates  => "${base}/Dash/DocSets.zip",
    path     => "/usr/bin",
    require  => Package['Dash'],
  }->

  exec { "unzip -o '${base}/Dash/DocSets.zip'":
    cwd      => "${base}/Dash",
    provider => 'shell',
    path     => "/usr/bin",
    require  => Package['Dash'],
 }
}
