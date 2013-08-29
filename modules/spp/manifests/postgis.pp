class spp::postgis {

  $files = "${boxen::config::repodir}/modules/spp/files/postgis"

  exec { "install postgis":
    command  => "ruby ${files}/postgis_153_installer.rb",
    provider => 'shell',
    require  => Package['boxen/brews/postgresql'],
  }

}
