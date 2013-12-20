# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod name, :path => "#{ENV['HOME']}/projects/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.3.5"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "dnsmasq",    "1.0.0"
github "foreman",    "1.0.0"
github "gcc",        "2.0.1"
github "git",        "1.3.2"
github "go",         "1.0.0"
github "homebrew",   "1.5.1"
github "hub",        "1.0.3"
github "inifile",    "1.0.0", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",      "1.4.2"
github "nodejs",     "3.3.0"
github "openssl",    "1.0.0"
github "phantomjs",  "2.1.0"
github "pkgconfig",  "1.0.0"
github "repository", "2.2.0"
github "ruby",       "6.7.6"
github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
github "xquartz",    "1.1.1"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

# SPP Modules

github "chrome",            "1.1.2"
github "gitx",              "1.2.0"
github "wget",              "1.0.0"
github "sysctl",            "1.0.0" # Required by postgresql

# The postgresql manifest we were using created the DB cluster with the
# default locale, which on our machines is usually en_AU.UTF-8.
# This causes the Atlas database_correctly_configured_spec to fail.
# This fork hardcodes the locale to en_US.UTF-8.
mod "postgresql",           :git => "https://github.com/TimMoore/puppet-postgresql.git",
                            :ref => 'hardcode-locale'

github "postgis",           "2.1.6", :repo => "lonelyplanet/puppet-postgis"

github "iterm2",            "1.0.6"
github "shiftit",           "0.0.2", :repo => "jlgeering/puppet-shiftit"
github "osx",               "1.6.0"
github "property_list_key", "0.2.0", :repo => "glarizza/puppet-property_list_key"
github "pgadmin3",          "1.0.0"
github "alfred",            "1.1.7"
github "virtualbox",        "1.0.9"
github "openoffice",        "1.2.0"
github "firefox",           "1.1.7"
github "java",              "1.2.0"  # Needed for Simian in the Atlas/Remixer builds

# Personal Modules (Used in modules/people/manifests/$user.pp)
github "minecraft",         "1.0.0"
