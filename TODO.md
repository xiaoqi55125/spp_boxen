### TODO

- **Cannot run `./script/boxen` OR `git push` when logged into a devmac over an ssh connection**. Boxen has a problematic relationship with the OSX keychain. Make it not so.

- **spp_boxen does not prompt for the hostname during install**. Make it not so.

### Manual Steps (post-install)

- passenger config is added to httpd.conf but the installer must still be run manually:

  ```bash
  $ cd atlas
  $ passenger-install-apache2-module
  $ sudo apachectl restart
  ```

- git-pair needs to be installed under system ruby:

  ```
  $ cd atlas
  $ sudo gem install ehrenmurdick-git-pair
  ```

- ghostscript needs to be setup correctly. Manually install via:

  ```
    brew uninstall freetype
    brew install freetype --from-source
    brew uninstall fontconfig
    brew install fontconfig --from-source
    brew uninstall ghostscript
    brew install ghostscript --from-source
  ```

- Quicksilver shows in dock (right-click, go to preferences, deselect 'show in dock') 
- setup printer
- native scrolling for mouse
- keyboard keypress repeat delay
- enable automatic login (System Preferences/Users & Groups/Login Options)
- turn off screensaver "require password" (System Preferences/Security & Privacy/Require password)
- Setup VirtualBox with a WindowsXP image - used for cross OS testing
- set the hostname (`sudo hostname` and possibly System Preferences/Sharing/Computer Name)

- these still need automating:
  * npm install -g coffee-script
  * configuration for PGAdmin
  * Skype
  * Disable cmd-space shortcut for Spotlight (so Quicksilver can use it)

- Permissions for pgAdmin.app are set incorrectly due to a bug in Boxen's `appdmg_eula` provider. To fix:

  ```
  sudo chown -R dev:staff /Applications/pgAdmin3.app
  ```

### Troubleshooting

#### dyld: Library not loaded: /opt/boxen/homebrew/lib/libtiff.5.dylib

run this command
```
  sudo ln -s /opt/boxen/homebrew/Cellar/libtiff/4.0.3/lib/libtiff.5.dylib /usr/lib/libtiff.5.dylib
```

#### Illegal instruction: 4' error

Something isn't installed from source. Run `brew info [app_name]` to tell you whether an app is installed from source. `libpng` needs to be install from source for remixer features to work, and possibly others.


#### Christo fails to fetch places and manifests?

Most likely an issue with your server. Hit atlas.local/server-info to get more information

#### Getting a Postgres error like: `PG::Error: ERROR: relation "geometry_columns" does not exist`

Postgis has not been setup correctly. Try re-installing with `script/boxen`.
See `spp_boxen/modules/spp/files/postgis_153_installer.rb` for details.

#### Getting a Postgres error like: `could not access file "$libdir/postgis-1.5": No such file or directory`

The postgresql installation is probably missing the postgis shared library.

You can verify the location of your postgresql shared library directory via pg_config:

`$ pg_config --pkglibdir`

which will probably be something like:

`/opt/boxen/homebrew/Cellar/postgresql/9.1.9-ocboxen/lib`

Check for the existence of the file: `postgis-1.5.so`. This ought to have been installed by boxen, but sometimes fails to materialise. Copying the binary across from another pairing station will resolve the problem until the spp_boxen scripts are fixed.


