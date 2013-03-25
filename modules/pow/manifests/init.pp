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

              # Use this resource instead if your platform's grep doesn't support -vFx;
              # note that this command has been known to have problems with lines containing quotes.
              # exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
              #     onlyif => "/bin/grep -qFx '${line}' '${file}'"
              # }
          }
      }
  }

  # launch at login
  file { "${$home}/Library/LaunchAgents/cx.pow.powd.plist":
    source  => "puppet:///modules/pow/cx.pow.powd.plist",
    require => Package["pow"],
  }->
  exec { "unload pow":
    command => "launchctl unload '${home}/Library/LaunchAgents/cx.pow.powd.plist' 2>/dev/null || true",
  }->
  exec { "load pow":
    command => "launchctl load -Fw '${home}/Library/LaunchAgents/cx.pow.powd.plist' 2>/dev/null",
  }->
  # Setup firewall
  file { "/Library/LaunchDaemons/cx.pow.firewall.plist":
    source  => "puppet:///modules/pow/cx.pow.firewall.plist",
  }->
  # line { "setup local nameserver":
  #   file => "/etc/resolver/${::luser}",
  #   line => "port 20560",
  # }->
  file { "/etc/resolver/local":
    content => "nameserver 127.0.0.1\nport 20560",
  }
  exec { "unload pow firewall":
    command => "launchctl unload '/Library/LaunchDaemons/cx.pow.firewall.plist' 2>/dev/null || true",
  }->
  exec { "load pow firewall":
    command => "launchctl load -Fw '/Library/LaunchDaemons/cx.pow.firewall.plist' 2>/dev/null",
  }
}