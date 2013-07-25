class config::postgis {

file { "Grab postgis setup SQL":
  path => "/tmp/boxen/create_postgis_template.sql",
  content  => template("spp/create_postgis_template.sql.erb"),
  require => Package['boxen/brews/postgis'],
}

exec { "Check for old PostGIS version (1.5.3) and prep for installing new version":
  command => join([
      'pg_dump -h localhost -p 15432 -Fc -b -v -f "/tmp/atlas_development.backup" atlas_development',
      'psql -h localhost -p 15432 -c "SELECT pg_terminate_backend(pg_stat_activity.procpid) FROM pg_stat_activity WHERE pg_stat_activity.datname = \'atlas_development\'" postgres',
      'psql -h localhost -p 15432 -c "drop DATABASE atlas_development" postgres',
      'brew uninstall postgis',
      'brew uninstall postgres', #Uninstalling /opt/boxen/homebrew/Cellar/postgresql/9.2.4....
      'brew uninstall postgres', #Uninstalling /opt/boxen/homebrew/Cellar/postgresql/9.1.9-ocboxen...
      'brew uninstall json-c',
      'rm -rf /opt/boxen/data/postgresql/'
    ], ' && '),
  onlyif => "psql -h localhost -p 15432 -c 'SELECT PostGIS_version()' atlas_development | grep -c 1.5",
  require => File["Grab postgis setup SQL"],
}

exec { "Setup postgres to work with postgis":
  command => "psql -p 15432 -d postgres -f /tmp/boxen/create_postgis_template.sql > /tmp/boxen/postgis.out",
  require => [Package['boxen/brews/postgis'], Exec["Check for old PostGIS version (1.5.3) and prep for installing new version"]],
}

exec { "Import data from PostGIS upgrade":
  command => join([
    'perl postgis_restore.pl "/tmp/atlas_development.backup" | psql -h localhost -p 15432 atlas_development',
    'mv /tmp/atlas_development.backup /tmp/atlas_development.backup.old', # Should rm but not, in case something went wrong and we still got here
    ], ' && '),
  onlyif => '[ -e /tmp/atlas_development.backup ]',
  require => Exec["Setup postgres to work with postgis"],
}

}
