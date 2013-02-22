class projects::atlas {

  include phantomjs

  boxen::atlas { 'atlas':
    memcached     => true,
    postgresql    => true,
    nginx         => true,
    ruby          => '1.9.3',
    source        => 'lonelyplanet/atlas'
  }

}