### TODO

- **Cannot run `./script/boxen` OR `git push` when logged into a devmac over an ssh connection**. Boxen has a problematic relationship with the OSX keychain. Make it not so.

- **spp_boxen does not prompt for the hostname during install**. Make it so.

### Manual Steps (post-install)

- passenger installer must still be run manually:
  ```
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

- hostname needs to be set in various places - we have a helper script:
  ```
  sudo set_hostname devmac-8  # or devmac-10, or devmac-11, or...
  ```

- these also need manual intervention:
  * installation of Skype
  * enable automatic login (System Preferences/Users & Groups/Login Options)
  * Quicksilver shows in dock (right-click, go to preferences, deselect 'show in dock') 
  * disable cmd-space shortcut for Spotlight (so Quicksilver can use it)
  * setup printer
  * keyboard keypress repeat delay
  * Setup VirtualBox with a WindowsXP image - used for cross OS testing

---

### Troubleshooting

#### dyld: Library not loaded: /opt/boxen/homebrew/lib/libtiff.5.dylib

run this command:
  ```
    sudo ln -s /opt/boxen/homebrew/Cellar/libtiff/4.0.3/lib/libtiff.5.dylib /usr/lib/libtiff.5.dylib
  ```

---

#### error: "Illegal instruction: 4"

Something isn't installed from source. Run `brew info [app_name]` to tell you whether an app is installed from source. `libpng` needs to be install from source for remixer features to work, and possibly others.


---

#### Christo fails to fetch places and manifests?

Most likely an issue with your server. Hit atlas.local/server-info to get more information

---

#### error: "PG::Error: ERROR: relation 'geometry_columns' does not exist"

Postgis has not been setup correctly. Try:
  ```
  cd atlas
  ber db:clone_devint
  ```
Otherwise, re-install postgis with `script/boxen`

---

#### error: "could not access file '$libdir/postgis-1.5': No such file or directory"

Postgresql is missing the postgis shared library.
Try (re)running: `script/boxen`

NB: pg_config can show the location of the postgresql shared library directory: `pg_config --pkglibdir`, which will be something like:
  ```
  /opt/boxen/homebrew/Cellar/postgresql/9.1.9-ocboxen/lib
  ```

Check for the existence of: `postgis-1.5.so`. As a quick hack, copy this binary across from another devmac.


