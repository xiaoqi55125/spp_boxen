class config::source_tree {

  $app_support_base = "/Users/${::luser}/Library/Application Support/SourceTree"

  file { $app_support_base:
    ensure  => 'directory',
    owner   => "${::luser}",
    mode    => '0755',
  }->

  file { "${app_support_base}/sourcetree.license":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/licenses/sourcetree.license",
    require => [Package['SourceTree'], Repository["${::boxen_srcdir}/pairing_station"]],
  }
}
