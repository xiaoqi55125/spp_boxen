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
