### TODO

- **Cannot run `./script/boxen` OR `git push` when logged into a devmac over an ssh connection**. Boxen has a problematic relationship with the OSX keychain. Make it not so.

- **spp_boxen does not prompt for the hostname during install**. Make it so.

### Manual Steps (post-install)

- passenger installer must still be run manually:
  ```bash
  cd atlas
  passenger-install-apache2-module
  sudo apachectl restart
  ```

- git-pair needs to be installed under system ruby:
  ```
  cd atlas
  sudo gem install ehrenmurdick-git-pair
  ```

- local db needs setup with realistic content:
  ```
  cd atlas
  ber db:clone_devint
  ```

- ghostscript needs re-installing to be setup correctly:
  ```
    brew uninstall freetype
    brew install freetype --from-source
    brew uninstall fontconfig
    brew install fontconfig --from-source
    brew uninstall ghostscript
    brew install ghostscript --from-source
  ```

- coffeescript needs installing (should be automated):
  ```
  npm install -g coffee-script
  ```

- these steps require manual intervention:
  * installation of Skype
  * set the hostname (`sudo hostname` and edit System Preferences/Sharing/Computer Name)
  * enable automatic login (System Preferences/Users & Groups/Login Options)
  * Quicksilver shows in dock (right-click, go to preferences, deselect 'show in dock') 
  * disable cmd-space shortcut for Spotlight (so Quicksilver can use it)
  * setup printer
  * keyboard keypress repeat delay
  * Setup VirtualBox with a WindowsXP image - used for cross OS testing


### Troubleshooting

#### dyld: Library not loaded: /opt/boxen/homebrew/lib/libtiff.5.dylib

run this command:
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


