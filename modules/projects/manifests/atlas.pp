class projects::atlas {

  include phantomjs
  include postgresql
  include postgis
  include java # Needed for Simian in the Atlas/Remixer builds

  $ruby_version = '1.9.3-p484'
  $passenger_version = '4.0.29'

  ruby::gem { "passenger for atlas":
    gem => 'passenger',
    ruby => $ruby_version,
    version => $passenger_version
  }

  boxen::project { 'atlas':
    postgresql    => true,
    ruby          => $ruby_version,
    source        => 'lonelyplanet/atlas'
  }

  file { '/private/etc/apache2/other/atlas-vhost.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'wheel',
    mode    => 0644,
    content => template('projects/atlas-vhost.conf.erb')
  }

  file { '/opt/boxen/data/postgresql/postgresql.conf':
    ensure  => file,
    mode    => '0600',
    source  => "puppet:///modules/projects/postgresql.conf",
    require => Package['boxen/brews/postgresql'],
  }

  exec { 'atlas DB users':
    command => "${boxen::config::srcdir}/atlas/script/db/setup_db_roles.sh",
    cwd     => "${boxen::config::srcdir}/atlas",
    require => [ Package['boxen/brews/postgresql'], Boxen::Project['atlas'] ],
  }
}
