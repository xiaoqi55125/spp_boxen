class spp::postgis {

  $files = "${boxen::config::repodir}/modules/spp/files/postgis"

  # 2013-08-30
  # we are tied to a particular, old version of postgis: 1.5.3
  # hence our need to install old versions of geos and proj

  # manual installation would look something like:
  # $ cd /opt/boxen/homebrew/
  # $ git checkout d751bc9 Library/Formula/geos.rb  # 3.3.8
  # $ git checkout e250bfb Library/Formula/proj.rb  # 4.8.0

  exec { "install geos":
    command  => "brew install ${files}/geos.rb",
    provider => 'shell',
    unless   => "geos-config --version | grep -c 3.3.8",
  }

  exec { "install proj":
    command  => "brew install ${files}/proj.rb",
    provider => 'shell',
    unless   => "proj 2>&1 | grep -c 4.8.0",
  }

  exec { "install postgis":
    command  => "ruby ${files}/postgis_153_installer.rb",
    provider => 'shell',
    require  => [Package['boxen/brews/postgresql'],
                 Exec['install geos'],
                 Exec['install proj'],
                ],
  }

}
