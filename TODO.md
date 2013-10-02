### TODO

- **spp_boxen does not prompt for the hostname during install**. Make it so.

### Manual Steps (post-install)

- `hostname` needs configuring in various places. Run:
  ```
  sudo set_hostname devmac-8  # or devmac-10, or devmac-11, or...
  ```

- install passenger:
  ```
  cd atlas
  passenger-install-apache2-module
  sudo apachectl restart
  ```

- install `git-pair` under system ruby:
  ```
  cd atlas
  sudo gem install ehrenmurdick-git-pair
  ```

- setup local db setup with realistic content:
  ```
  cd atlas
  ber db:clone_devint
  RAILS_ENV=test ber db:setup
  ```

- re-install ghostscript (to set it up correctly):
  ```
    brew uninstall freetype
    brew install freetype --from-source
    brew uninstall fontconfig
    brew install fontconfig --from-source
    brew uninstall ghostscript
    brew install ghostscript --from-source
  ```

- install coffeescript:
  ```
  npm install -g coffee-script
  ```

- you might also want to setup:
  * Skype
  * the printer
  * VirtualBox with a WindowsXP image (used for cross OS testing) (WindowXP makes me very cross)
  * automatic login (System Preferences/Users & Groups/Login Options)
  * disable cmd-space shortcut for Spotlight (so Alfred can use it)
  * keyboard keypress repeat delay (System Preferences/Keyboard)
  * start Dash and enter app store password to enable it properly
---

### Troubleshooting

#### Boxen Keychain Helper: Encountered error code: -25308, Error: User interaction is not allowed.

If you see this error when ssh'd into a devmac, run this command:
  ```
  security unlock-keychain
  ```

For details, see: `https://github.com/boxen/boxen/issues/54#issuecomment-15938565`

---

#### dyld: Library not loaded: /opt/boxen/homebrew/lib/libtiff.5.dylib

run this command:
  ```
    sudo ln -s /opt/boxen/homebrew/Cellar/libtiff/4.0.3/lib/libtiff.5.dylib /usr/lib/libtiff.5.dylib
  ```

---

#### error: "Illegal instruction: 4"

Something isn't installed from source. Run `brew info [app_name]` to tell you whether an app is installed from source. `libpng` needs to be installed from source/re installed for remixer features to work, and possibly others.

Checking the OSX Console for crash reports can help find which lib is failing:

```
Exception Type:  EXC_BAD_INSTRUCTION (SIGILL)
Exception Codes: 0x0000000000000001, 0x0000000000000000

Thread 0 Crashed:: Dispatch queue: com.apple.main-thread
0   libpng15.15.dylib             	0x0000000108fa4f1f png_write_destroy + 238
1   libpng15.15.dylib             	0x0000000108fa4e09 png_destroy_write_struct + 181
2   gs                            	0x0000000108948018 do_png_print_page + 1533
```

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

#### ERROR:  Error installing debugger-linecache: ERROR: Failed to build gem native extension.

Run these two commands manually if you get this error when bundle installing on remixer
'''
gem install debugger-ruby_core_source -v '1.1.7'
gem install debugger
'''

Then run bundle install
