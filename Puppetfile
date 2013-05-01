# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

def include_dependency(name, version_tag="1.0.0", options = {})
  options[:repo] ||= "boxen/puppet-#{name}"
  mod name, version_tag, :github_tarball => options[:repo]
end

# Boxen Defaults

include_dependency "boxen",    "1.2.0"
include_dependency "gcc"
include_dependency "git"
include_dependency "homebrew", "1.1.2"
include_dependency "hub"
include_dependency "inifile",  "0.9.0", :repo => "cprice-puppet/puppetlabs-inifile"
include_dependency "nodejs"
include_dependency "nvm"
include_dependency "ruby",     "3.4.0"
include_dependency "stdlib",   "3.0.0", :repo => "puppetlabs/puppetlabs-stdlib"
include_dependency "sudo"

# Optional/custom modules. There are tons available at https://github.com/boxen.

# SPP Modules

include_dependency "chrome"
include_dependency "firefox",          "1.0.0", :repo => "lonelyplanet/puppet-firefox"
include_dependency "gitx"
include_dependency "wget"
include_dependency "sysctl" # Required by postgresql
include_dependency "postgresql"
include_dependency "postgis",          "2.1.0", :repo => "lonelyplanet/puppet-postgis"
include_dependency "iterm2"
include_dependency "phantomjs"
include_dependency "java",      "1.0.6"
include_dependency "shiftit",          "0.0.2", :repo => "jlgeering/puppet-shiftit"
include_dependency "xquartz"
include_dependency "pow",         		   "0.1.2", :repo => "mriddle/puppet-pow"
include_dependency "osx"
include_dependency "property_list_key",  "0.1.0", :repo => "glarizza/puppet-property_list_key"

# Personal Modules (Used in modules/people/manifests/$user.pp)
include_dependency "minecraft"
