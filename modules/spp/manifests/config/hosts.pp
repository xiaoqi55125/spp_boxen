class config::hosts {

  file { "/etc/hosts":
    ensure  => present,
    owner => 'root',
    group => 'wheel',
    mode => 0644,
    source  => "puppet:///modules/spp/hosts"
  }

}
