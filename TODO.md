# TODO

These setup steps are not yet automated.

When you find something missing from the Boxen configuration, add it here with
as many of these details as you can provide:

  - Exactly how to manually perform the step. Include URLs, commands to run,
    etc.
  - Why it is needed (e.g., it's a dependency of some app). These things can
    change over time, so the more detail we include about the reason for a
    manual step, the easier it is to evaluate whether we still need it in the
    future.
  - If you tried to automate it in Boxen, what difficulties you encountered.
    This helps to prevent several people trying the same unsuccessful
    automation strategies over and over.

### Manual Steps (post-install)

  - `hostname` needs configuring in various places. Run:
    ```
    sudo set_hostname devmac-8  # or devmac-10, or devmac-11, or...
    ```

    - _Why we need it:_ the default hostname chosen by the OSX installer is not
      very useful. We want to be able to ssh to these machines by name.
    - _Why it's hard to automate:_ we can't auto-detect the value, and we
      haven't figured out how to make Boxen prompt for it.

  - install passenger:
    ```
    cd atlas
    passenger-install-apache2-module
    sudo apachectl restart
    ```

    - _Why we need it:_ this is required to make Apache work with Passenger.
      This is how we run Atlas and Remixer locally (as well as in production).
      Before this step is run, Apache fails to start up.
    - _Why it's hard to automate:_ this command is installed by a gem into the
      Ruby version managed by `rbenv` for Atlas. We haven't figured out how to
      run commands within the context of that environment with Boxen.
    - Another strategy to try: modifying the
      [Homebrew formula](https://github.com/mxcl/homebrew/blob/master/Library/Formula/passenger.rb)
      and installing that way.

  - install `git-pair` under the default gem path:
    ```
    cd atlas
    gem install ehrenmurdick-git-pair
    ```

    - _Why we need it:_ we use this to manage the git configuration when
      pairing.
    - _Why it's hard to automate:_ this is in the atlas Gemfile, but for some
      reason, Bundler is configured with `BUNDLE_PATH: /Users/dev/.bundle`,
      which is not on our default `PATH`.

  - add content to the local DB:
    ```
    cd atlas
    ber db:clone_devint
    RAILS_ENV=test ber db:setup
    ```

    - _Why we need it:_ prod-like data is useful for development and testing.
    - _Why it's hard to automate:_ ???

  - re-install ghostscript (to set it up correctly):
    ```
    brew uninstall freetype;    brew install freetype --from-source
    brew uninstall fontconfig;  brew install fontconfig --from-source
    brew uninstall ghostscript; brew install ghostscript --from-source
    ```

    - _Why we need it:_ ??? required by Remixer?
    - _Why it's hard to automate:_ ???

  - install CoffeeScript node package:
    ```
    npm install -g coffee-script
    ```

    - _Why we need it:_ this is the standard CoffeeScript compiler, used by SublimeText et. al.
    - _Why it's hard to automate:_ this is a node (npm) module, and npm assumes the presence of a shell

  - create Atlas2Ninjas profile in chrome
    * login to google as atlas2ninjas@lonelyplanet.com.au
      (details: https://lonelyplanet.atlassian.net/wiki/display/SPP/Shared+Accounts#SharedAccounts-Google)

  - install Bling development VM (WinXP, used for cross OS testing (WinXP makes me very cross)
    ```
    mkdir -p /Users/dev/VirtualBox\ VMs/BlingDevelopment
    rsync -av --progress --stats "devmac-1:/Users/dev/VirtualBox\\ VMs/BlingDevelopment" /Users/dev/VirtualBox\ VMs/BlingDevelopment
    ```

    * load vm

  - map Caps Lock to Ctrl

  - you might also want to setup:
    * Skype
    * the printer
    * automatic login (System Preferences/Users & Groups/Login Options)
    * keyboard keypress repeat delay (System Preferences/Keyboard)
    * start Dash and enter app store password to enable it properly
    * Add Chrome, iTerm, and Sublime to the Dock
    * Disable the guest user

---

### Troubleshooting

---

#### xcrun: Error: failed to exec real xcrun

Often hidden behind the inability of native gems to compile, e.g:
```
Gem::Installer::ExtensionBuildError: ERROR: Failed to build gem native extension.

        /opt/boxen/rbenv/versions/1.9.3-p484/bin/ruby extconf.rb
Extracting libxml2-2.8.0.tar.gz into tmp//ports/libxml2/2.8.0... OK
Running 'configure' for libxml2 2.8.0... ERROR, review 'tmp//ports/libxml2/2.8.0/configure.log' to see what happened.
*** extconf.rb failed ***
```

You can verify by invoking gcc:
```
$ gcc --version
$ xcrun: Error: failed to exec real xcrun
```

This issue is related to the shim-based management of gcc within OSX. The fix depends on the version of XCode installed.

command-line tools:
```sudo xcode-select -switch /usr/bin```

XCode 4.x:
```sudo xcode-select -switch /Applications/Xcode.app```

XCode 5.x:
```sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer```

---

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
```
  gem install debugger-ruby_core_source -v '1.1.7'
  gem install debugger
  bundle install
```

