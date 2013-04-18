class spp::applications {

  include iterm2::stable
  include gitx
  include wget
  include firefox
  include chrome
  include shiftit
  include xquartz
  include pow

  # Not installing cause of a license prompt ><
  # package { "PGAdmin":
  #   provider => 'appdmg',
  #   source => 'http://ftp.postgresql.org/pub/pgadmin3/release/v1.16.1/osx/pgadmin3-1.16.1.dmg'
  # }

  package { "Quicksilver":
    ensure => "present",
    provider => 'appdmg',
    source => 'https://github.com/downloads/quicksilver/Quicksilver/Quicksilver%20B70.dmg',
  }

  package { 'SublimeText2':
    provider => 'appdmg',
    source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg';
  }

  package { 'SourceTree':
    provider => 'appdmg',
    source => 'http://downloads.atlassian.com/software/sourcetree/SourceTree_1.5.8.dmg'
  }

}
