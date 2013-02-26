### Minimum set of requirements

**Purpose**

The ability to provision a iMac with minimal & acceptable development environment. Aimed at Atlas only.

**Things to install**

- iTerm2
  - No solarized
- Sublime Text 2
  - No plugins included
  - No solarized
- Chrome
- Firefox
- postgresql (postgis)
- apache (passenger/nginx)
- rvm/rbenv
- ~memcached (possibly?)~
- gitx (source tree comes later)
- phantomjs
- Atlas git repository  

(*We can skip auto-configuring most of these for now*)

**Things to configure**

- postgresql (postgis)
- rvm/rbenv
- apache (passenger/nginx)
- ssh keys (could be manual yo)
- dotfiles (depending how easy)

### How to go about it all

**SPP Module**
 - Create a lonelyplanet spp puppet module on github
  - Add applications mentioned above to it 
  - Add projects under it, like Atlas

**Projects**

- Project definitions should include all required dependencies.
- Might be worth creating a shared dependencies project

