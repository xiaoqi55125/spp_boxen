class config::dash {

  $base = "/Users/${::luser}/Library/Application Support"

  $structure = [ "${base}/Dash" ]

  file { $structure:
    ensure  => 'directory',
    owner   => "${::luser}",
    mode    => '0755',
  }

  $docSetsLink = "https://s3-ap-southeast-2.amazonaws.com/spp-boxen/DocSets.zip"
  exec { "curl -o DocSets.zip ${docSetsLink}":
    cwd      => "${base}/Dash",
    provider => 'shell',
    creates  => "${base}/Dash/DocSets.zip",
    path     => "/usr/bin",
    require  => Package['Dash'],
  }
}
