
class spp::licenses {

  file { "/Users/${::luser}/Library/Application Support/Sublime Text 2/Settings/License.sublime_license":
    ensure  => link,
    mode    => '0644',
    target  => "${::boxen_srcdir}/pairing_station/licenses/License.sublime_license",
    require => [Package['SublimeText2'], Repository["${::boxen_srcdir}/pairing_station"]],
  }

  # sourcetree.license cannot be a symlink
  file { "/Users/${::luser}/Library/Application Support/SourceTree/sourcetree.license":
    ensure  => present,
    mode    => '0644',
    source  => "${::boxen_srcdir}/pairing_station/licenses/sourcetree.license",
    require => [Package['SourceTree'], Repository["${::boxen_srcdir}/pairing_station"]],
  }

}
