### Minimum set of requirements

**Purpose**

The ability to provision a iMac with a minimal acceptable SPP development environment.
Setup under the github user sppdev. Which is the user all shared macs should be provisioned as.

**Things to install**

- setup hostname somehow
  ```puppet
  exec {"set computer name":
    command => "scutil --set ComputerName 'air-pedro'",
    user => 'root',
    path    => ["/usr/bin", "/usr/sbin", "/bin"]
  }
  exec {"set host name":
    command => "scutil --set HostName 'air-pedro'",
    user => 'root',
    path    => ["/usr/bin", "/usr/sbin", "/bin"]
  }
  exec {"set local host name":
    command => "scutil --set LocalHostName 'air-pedro'",
    user => 'root',
    path    => ["/usr/bin", "/usr/sbin", "/bin"]
  }
  ```
- ~~iTerm2~~
  - ~~Solarized~~
- ~~Sublime Text 2~~
  - ~~Plugins~~
  - ~~Solarized~~
- ~~Chrome~~
- ~~Firefox~~
- ~~postgresql (postgis)~~
- ~~pow~~
- ~~rvm/rbenv~~
- ~~memcached (possibly?)~~
- ~~gitx~~ (source tree comes later)
- ~~phantomjs~~
- ~~Atlas git repository~~
- ~~java~~
- ~~xquartz (X11 replacement)~~

(*We can skip auto-configuring most of these for now*)

**Things to configure**

- postgresql (postgis)
- rvm/rbenv
- apache (passenger/nginx)
- ssh keys (could be manual yo)
- dotfiles (depending how easy)
  - cdpath
### How to go about it all

**Things we still need to understand**
 - ~~Why doesn't our lonelyplanet/puppet-firefox module install~~
 - ~~How do we configure post-installation.~~

**SPP Module**
 - ~~Create a lonelyplanet spp puppet module on github~~
  - ~~Add applications mentioned above to it~~
  - ~~Add projects under it, like Atlas~~

**Projects**

- ~~Project definitions should include all required dependencies.~~
- ~~Might be worth creating a shared dependencies project~~

##Nice to have
- Cpu monitor
- Mouse direction - normal
- ~~Shiftit~~
  - config to start on startup
  - needs to enable accessibility API via mac preferences
  - check for updates automatically
- ~~dbvisualizer~~
 - setup with all our DBs
- ~~quicksilver~~
- Setup shiftit and quicksilver as login items
  - ~~Enable access for assistive devices in accessibility options~~
- Dock options
  - ~~Remove default crap~~
  - ~~Autohide~~
- Chrome as default browser
- Chrome should be setup with atlas2ninjas account
- Turn off native scrolling
