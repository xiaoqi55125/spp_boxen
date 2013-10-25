class config::source_tree {

  $app_support = "/Users/${::boxen_user}/Library/Application Support/SourceTree"

  file { $app_support:
    ensure  => 'directory',
    owner   => "${::boxen_user}",
    mode    => '0755',
  }->

  file { "${app_support}/browser.plist":
    ensure  => present,
    source  => "puppet:///modules/spp/source_tree/browser.plist"
  }

  file { "${app_support}/hgrc_sourcetree":
    ensure  => present,
    source  => "puppet:///modules/spp/source_tree/hgrc_sourcetree"
  }

  file { "${app_support}/hostingservices.plist":
    ensure  => present,
    source  => "puppet:///modules/spp/source_tree/hostingservices.plist"
  }

  file { "${app_support}/openWindowList":
    ensure  => present,
    source  => "puppet:///modules/spp/source_tree/openWindowList"
  }
}
