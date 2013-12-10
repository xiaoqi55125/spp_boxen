class spp::applications {

  include iterm2::stable
  include gitx
  include wget
  include chrome
  include shiftit
  include xquartz
  include pgadmin3
  include alfred
  include virtualbox
  include openoffice

  define uninstall ($app_name = $title, $type) {
    exec { "Remove app ${app_name}" :
      command => "rm -rf '/Applications/${app_name}.app'; rm -f '/var/db/.puppet_${type}_installed_${app_name}'",
      user => "root",
      onlyif => "test -e '/Applications/${app_name}.app'"
    }
  }

  package { 'Firefox':
    provider => 'appdmg',
    source   => 'http://download-origin.cdn.mozilla.net/pub/mozilla.org/firefox/releases/25.0/mac/en-US/Firefox%2025.0.dmg'
  }

  uninstall {'Quicksilver':
    type => 'appdmg'
  }

  package { 'SublimeText2':
    provider => 'appdmg',
    source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.dmg'
  }

  package { 'SourceTree':
    provider => 'appdmg',
    source   => 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.7.4.1.dmg',
  }

  homebrew::formula { 'tig':
    before => Package['boxen/brews/tig'],
  }

  package { 'boxen/brews/tig':
    ensure => installed,
  }

  package { 'ChickenVNC':
    provider => 'appdmg',
    source => 'http://freefr.dl.sourceforge.net/project/chicken/Chicken-2.2b2.dmg'
  }

  package { 'Dash':
    provider => 'compressed_app',
    source => 'https://s3-ap-southeast-2.amazonaws.com/spp-boxen/Dash.zip'
  }

  package { 'DbVisualizer':
    provider => 'compressed_app',
    source => 'http://www.dbvis.com/product_download/dbvis-8.0.12/media/dbvis_macos_8_0_12.tgz'
  }

  $dbvis_tarball = "${::boxen_srcdir}/pairing_station/preferences/dbvisualizer/_dbvis_preferences.tgz"

  exec { 'DbVisualizer Prefs':
    command  => "tar -zxvf ${dbvis_tarball}",
    provider => 'shell',
    cwd      => "/Users/${::luser}",
    require  => [Package['DbVisualizer'], Repository["${::boxen_srcdir}/pairing_station"]],
  }

  exec { "install watch":
    command  => "brew install watch",
    provider => 'shell',
    unless   => "ls -l ${::boxen::config::homebrewdir}/bin | grep -ic watch",
  }

  exec { 'AWS CLI':
    command => 'easy_install awscli',
    user => 'root',
    creates => '/usr/local/bin/aws'
  }
}
