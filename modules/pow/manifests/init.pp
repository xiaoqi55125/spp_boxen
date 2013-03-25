class pow {
  package { "pow": }

  $home = "/Users/${::luser}"

  # Setup pow dir
  file { "${home}/.pow":
    target  => "${home}/Library/Application Support/Pow/Hosts",
    ensure  => "link",
    require => Package["pow"]
  }

  define line($file, $line, $ensure = 'present') {
      case $ensure {
          default : { err ( "unknown ensure value ${ensure}" ) }
          present: {
              exec { "echo '${line}' >> '${file}'":
                  unless => "grep -qFx '${line}' '${file}'",
                  user => 'root',
              }
          }
          absent: {
              exec { "grep -vFx '${line}' '${file}' | tee '${file}' > /dev/null 2>&1":
                onlyif => "grep -qFx '${line}' '${file}'"
              }
          }
      }
  }

  # Add dev resolver
  file { "/etc/resolver/dev":
    content => "nameserver 127.0.0.1\nport 20560",
    group   => 'wheel',
    owner   => 'root',
  }->

  # Setup firewall
  file { "/Library/LaunchDaemons/cx.pow.firewall.plist":
    source  => "puppet:///modules/pow/cx.pow.firewall.plist",
    group   => 'wheel',
    owner   => 'root',
  }->
  exec { "unload pow firewall":
    command => "launchctl unload '/Library/LaunchDaemons/cx.pow.firewall.plist' || true",
  }->
  exec { "load pow firewall":
    command => "launchctl load -w '/Library/LaunchDaemons/cx.pow.firewall.plist'",
    user => 'root',
  }->

  # # launch at login
  file { "${$home}/Library/LaunchAgents/cx.pow.powd.plist":
    source  => "puppet:///modules/pow/cx.pow.powd.plist",
    require => Package["pow"],
  }->
  exec { "unload pow":
    command => "launchctl unload '${home}/Library/LaunchAgents/cx.pow.powd.plist' || true",
  }->
  exec { "load pow":
    command => "launchctl load -w '${home}/Library/LaunchAgents/cx.pow.powd.plist'",
  }->
  # Still need to run curl get.pow.cx/ | sh
  # Cause the server works but hitting atlas.dev times out.. I am missing a step in the install process
  # Why I do it like this? Because running the module via github redbubble/pow or lonelyplanet/pow doesn't work
  # Getting puppet to exec {curl get.pow.cx/ | sh} also does not work. They fail for the same reason. Trying to
  # interact with the pow install. Running pow --install-local or any other --command hangs!

}