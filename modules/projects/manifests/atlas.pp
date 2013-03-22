class projects::atlas {

  include phantomjs
  include postgresql
  include java
  include postgis

  boxen::project { 'atlas':
    postgresql    => true,
    nginx         => true,
    ruby          => '1.9.3',
    source        => 'lonelyplanet/atlas'
  }

}