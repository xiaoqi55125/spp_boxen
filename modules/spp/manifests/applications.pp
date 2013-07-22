class spp::applications {

  include iterm2::stable
  include gitx
  include wget
  include chrome
  include shiftit
  include xquartz

  # Not installing cause of a license prompt ><
  # package { "PGAdmin":
  #   provider => 'appdmg',
  #   source => 'http://ftp.postgresql.org/pub/pgadmin3/release/v1.16.1/osx/pgadmin3-1.16.1.dmg'
  # }

  package { 'Firefox':
    provider => 'appdmg',
    source   => 'http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/21.0/mac/en-US/Firefox%2021.0.dmg'
  }

  package { "Quicksilver":
    ensure => "present",
    provider => 'appdmg',
    source => 'https://github.com/downloads/quicksilver/Quicksilver/Quicksilver%20B70.dmg'
  }

  package { 'SublimeText2':
    provider => 'appdmg',
    source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg'
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

  package { "OpenOffice":
    ensure => "present",
    provider => 'appdmg',
    source => 'http://waix.dl.sourceforge.net/project/openofficeorg.mirror/stable/3.4.1/Apache_OpenOffice_incubating_3.4.1_MacOS_x86_install_en-US.dmg'
  }

}
