class spp::applications {

  include iterm2::stable
  include gitx
  include wget
  include chrome
  include shiftit
  include xquartz
  include pgadmin3

  package { 'Firefox':
    provider => 'appdmg',
    source   => 'http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/23.0.1/mac/en-US/Firefox%2023.0.1.dmg'
  }

  package { "Quicksilver":
    ensure => "present",
    provider => 'appdmg',
    source => 'https://github.com/downloads/quicksilver/Quicksilver/Quicksilver%20B70.dmg'
  }

  package { 'SublimeText2':
    provider => 'appdmg',
    source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.dmg'
  }

  package { 'SourceTree':
    provider => 'appdmg',
    source => 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.5.8.dmg'
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
}
