# Notes

A few things that we have learnt along the way.

- Boxen has a nuke mechanism that can remove itself. Do this by running
  ```
  cd ~/projects/spp_boxen
  script/nuke --all --force
  cd 
  rm -rf ~/projects/spp_boxen
  ```
- If experiencing weird issues with re-installing an app with Boxen try removing the puppet receipt from /var/db/.puppet_*. I had to do this to reinstall Sublime Text `rm -rf /var/db/.puppet_appdmg_installed_SublimeText2`. For some reason nuking didn't clear it up. Found [this GitHub issue](https://github.com/boxen/our-boxen/issues/84) Not sure if I was affected by it.
- [Some great info on how to order resources](http://docs.puppetlabs.com/learning/ordering.html) in a puppet file. FYI, the order is what ever puppet determines. Not the natural order of the file
- **MUST READ** [this blog post](http://garylarizza.com/blog/2013/02/15/puppet-plus-github-equals-laptop-love/). It gives you a great understanding of how Boxen & puppet work


**How to add a gem**

```puppet
  package { ["rack", "passenger"]:
    ensure => installed,
    provider => "gem",
  }
```
**How to update iTerm preferences**

 1. Make your change in iTerm.
 2. Export the changes with:

    ```shell
    $ plutil -convert xml1 \
      -o ~/projects/spp_boxen/modules/spp/files/com.googlecode.iterm2.plist \
      ~/Library/Preferences/com.googlecode.iterm2.plist
    ```
 3. Commit.