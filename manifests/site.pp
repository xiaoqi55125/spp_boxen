require boxen::environment
require homebrew
require gcc

include boxen::config

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $luser,

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
    "HOME=/Users/${::luser}"
  ]
}

File {
  group => 'staff',
  owner => $luser
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
  config => {
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
  include nodejs::v0_4
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default node version
  class { 'nodejs::global':
    version => 'v0.10'
  }

  # default ruby versions
  include ruby::1_9_3_p484 # All of our projects use this
  include ruby::2_0_0      # We don't use it yet, but it's useful to have

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar',
      'csshX',
      'bash-completion',
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

}
