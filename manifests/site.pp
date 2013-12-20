require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    # see:  https://github.com/boxen/our-boxen/issues/286#issuecomment-18516146
    # also: https://github.com/boxen/our-boxen/issues/286#issuecomment-18508672
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  },
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include git
  include hub

  # node versions
  include nodejs::v0_10

  # default node version
  class { 'nodejs::global':
    version => 'v0.10'
  }

  # default ruby versions
  include ruby::1_9_3_p484 # All of our projects use this
  include ruby::1_9_3      # Alias for 1.9.3-p484
  include ruby::2_0_0      # We don't use it yet, but it's useful to have

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar',
      'csshX',
      'bash-completion',
      'watch',
      'jq',  # http://stedolan.github.io/jq/
      'tig', # http://jonas.nitro.dk/tig/
      'brew-gem', # Allows installation of gems as if they were Homebrews
    ]:
  }

  # This installs git-pair using brew gem.
  # This way, it acts as a system command rather than as a gem.
  package { 'ehrenmurdick-git-pair':
    provider => brew_gem,
    require  => Package['brew-gem'],
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

}
