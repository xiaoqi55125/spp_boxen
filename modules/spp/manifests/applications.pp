class spp::applications {

  include iterm2::stable
  include gitx
  include wget
  include chrome
  include shiftit
  include xquartz
  include pgadmin3
  include alfred


  define uninstall ($app_name = $title, $type) {
    exec { "Remove app ${app_name}" :
      command => "rm -rf '/Applications/${app_name}.app'; rm -f '/var/db/.puppet_${type}_installed_${app_name}'",
      user => "root",
    }
  }

  package { 'Firefox':
    provider => 'appdmg',
    source   => 'http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/23.0.1/mac/en-US/Firefox%2023.0.1.dmg'
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
    source   => 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.6.4.1.dmg',
  }

  package { "tig":
    ensure => installed,
  }

  package { 'ChickenVNC':
    provider => 'appdmg',
    source => 'http://freefr.dl.sourceforge.net/project/chicken/Chicken-2.2b2.dmg'
  }

  package { 'GrowlNotify':
    provider => 'compressed_pkg',
    source => 'http://growl.cachefly.net/GrowlNotify-1.3.zip'
  }

  package { 'Dash':
    provider => 'compressed_app',
    source => 'https://s3-ap-southeast-2.amazonaws.com/spp-boxen/Dash.zip'
  }
}
