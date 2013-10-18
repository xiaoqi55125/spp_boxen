class config::postgis {

  $files = "${::boxen::config::repodir}/modules/spp/files/postgis"

  exec { "Setup postgres to work with postgis":
    command => "psql -p 15432 -d postgres -f ${files}/create_postgis_template.sql > /tmp/boxen/postgis.out",
    require => Exec["install postgis"],
  }

}
