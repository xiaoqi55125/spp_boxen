class config::source_tree {

  $app_support = "/Users/${::luser}/Library/Application Support/SourceTree"

  file { $app_support:
    ensure  => 'directory',
    owner   => "${::luser}",
    mode    => '0755',
  }->

  file { "${app_support}/sourcetree.license":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/licenses/sourcetree.license",
    require => [Package['SourceTree'], Repository["${::boxen_srcdir}/pairing_station"]],
  }

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
