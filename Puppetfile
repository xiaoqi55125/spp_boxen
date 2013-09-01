# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

def github(name, version, options = nil)
  options ||= {}
  options[:repo] ||= "boxen/puppet-#{name}"
  mod name, version, :github_tarball => options[:repo]
end

# Includes many of our custom types and providers, as well as global
# config. Required.

# Running off a fork pending https://github.com/boxen/puppet-boxen/pull/62
mod "boxen", :git => 'https://github.com/TimMoore/puppet-boxen.git',
             :ref => 'appdmg_eula_permissions'

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "autoconf",   "1.0.0"
github "dnsmasq",    "1.0.0"
github "gcc",        "2.0.1"
github "git",        "1.3.2"
github "homebrew",   "1.4.1"
github "hub",        "1.0.3"
github "inifile",    "1.0.0", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",      "1.4.2"
github "nodejs",     "3.2.9"
github "openssl",    "1.0.0"
github "repository", "2.2.0"
github "ruby",       "6.3.4"
github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
github "xquartz",    "1.1.0"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

# SPP Modules

github "chrome",            "1.1.1"
github "gitx",              "1.0.0"
github "wget",              "1.0.0"
github "sysctl",            "1.0.0" # Required by postgresql
github "postgresql",        "1.0.3", :repo => "octanner/puppet-postgresql"
# github "postgis",          "2.1.0", :repo => "lonelyplanet/puppet-postgis"
github "iterm2",            "1.0.3"
github "phantomjs",         "1.0.0"
github "shiftit",           "0.0.2", :repo => "jlgeering/puppet-shiftit"
github "osx",               "1.0.0"
github "property_list_key", "0.1.0", :repo => "glarizza/puppet-property_list_key"
github "pgadmin3",          "1.0.0"

# Personal Modules (Used in modules/people/manifests/$user.pp)
github "minecraft",         "1.0.0"
