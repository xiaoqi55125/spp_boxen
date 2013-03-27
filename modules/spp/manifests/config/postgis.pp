class config::postgis {

file { "Grab postgis setup SQL":
  path => "/tmp/boxen/create_postgis_template.sql",
  content  => template("spp/create_postgis_template.sql.erb"),
  require => Package['boxen/brews/postgis'],
}

exec { "Setup postgres to work with postgis":
  command => "psql -p 15432 -d postgres -f /tmp/boxen/create_postgis_template.sql > /tmp/boxen/postgis.out",
  unless =>  "psql -l | grep 'template_postgis'",
  require => File["Grab postgis setup SQL"],
}

}