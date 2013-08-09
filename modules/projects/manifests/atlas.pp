class projects::atlas {

  include phantomjs
  include postgresql
  include postgis

  $ruby_version = '1.9.3-p392'
  $passenger_version = '3.0.17'

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
}
