class spp::applications {
  # Want to add a Homebrew package?
  #
  #  - If it's a dependency for one of our projects, add it to the appropriate
  #    file in modules/projects/manifests/.
  #  - If it's a generally-useful command-line tool, add it to the package list
  #    in site.pp.

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
  include firefox

  exec { 'Enable Accessibility API for ShiftIt':
    # This is required for ShiftIt to function on Mavericks.
    #
    # The equivalent in the UI is:
    #  - System Preferences > Security & Privacy > Privacy > Accessibility
    #  - Click the lock to make changes and authenticate
    #  - Check ShiftIt under "Allow the apps below to control your computer."
    #
    # A future version of ShiftIt is expected to handle enabling this at launch
    # time by prompting the user for root permission.
    #
    # When that is available, this workaround should be removed.
    #
    # See https://github.com/fikovnik/ShiftIt/issues/110 for details.
    command => "/usr/bin/sqlite3 '/Library/Application Support/com.apple.TCC/TCC.db' 'update access set allowed=1 where client like \"%org.shiftitapp.ShiftIt%\"'",
    user    => "root",
    onlyif  => "test -f '/Library/Application Support/com.apple.TCC/TCC.db'",
    before  => Package["ShiftIt"]
  }

  define uninstall ($app_name = $title, $type) {
    exec { "Remove app ${app_name}" :
      command => "rm -rf '/Applications/${app_name}.app'; rm -f '/var/db/.puppet_${type}_installed_${app_name}'",
      user => "root",
      onlyif => "test -e '/Applications/${app_name}.app'"
    }
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
    source => 'http://www.dbvis.com/product_download/dbvis-9.1.5/media/dbvis_macos_9_1_5.tgz'
  }

  $dbvis_tarball = "${::boxen_srcdir}/pairing_station/preferences/dbvisualizer/_dbvis_preferences.tgz"

  exec { 'DbVisualizer Prefs':
    command  => "tar -zxvf ${dbvis_tarball}",
    provider => 'shell',
    cwd      => "/Users/${::luser}",
    require  => [Package['DbVisualizer'], Repository["${::boxen_srcdir}/pairing_station"]],
  }

  exec { 'AWS CLI':
    command => 'easy_install awscli',
    user => 'root',
    creates => '/usr/local/bin/aws'
  }
}
