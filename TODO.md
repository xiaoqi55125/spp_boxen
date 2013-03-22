### Minimum set of requirements

**Purpose**

The ability to provision a iMac with a minimal acceptable SPP development environment. 
Setup under the github user sppdev. Which is the user all shared macs should be provisioned as.

**Things to install**

- setup hostname somehow
- ~~iTerm2~~
  - ~~Solarized~~
- ~~Sublime Text 2~~
  - ~~Plugins~~
  - ~~Solarized~~
- ~~Chrome~~
- ~~Firefox~~
- ~~postgresql (postgis)~~
- ~~apache (passenger/nginx)~~ **Running with nginx and unicorn**
  - I have yet to get the server automatically started on machine start. Create launchDaemon with


  ```xml
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
<dict>
    <key>Disabled</key>
    <false/>
    <key>UserName</key>
    <string>dev</string>
    <key>Label</key>
    <string>dev.unicorn</string>
    <key>ProgramArguments</key>
    <array>
            <string>/Users/dev/projects/atlas/script/server.sh</string>
    </array>
    <key>WorkingDirectory</key>
    <string>/Users/dev/projects/atlas</string>
    <key>RunAtLoad</key>
    <true/>
    <key>EnableTransactions</key>
    <false/>
    <key>KeepAlive</key>
    <false/>
    <key>AbandonProcessGroup</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/var/log/unicorn-agent.log</string>
    <key>StandardErrorPath</key>
    <string>/var/log/unicorn-agent.log</string>
</dict>
</plist>
  ```

  ```
  # sudo chmod 755 /Library/LaunchDaemons/dev.unicorn.plist
  # sudo launchctl load /Library/LaunchDaemons/dev.unicorn.plist
  ```


- ~~rvm/rbenv~~
- ~~memcached (possibly?)~~
- ~~gitx~~ (source tree comes later)
- phantomjs
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
