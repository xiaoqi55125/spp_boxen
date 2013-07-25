## TODO

 - passenger config is added to httpd.conf but must still run installer manually:
```bash
passenger-install-apache2-module
sudo apachectl restart
```

- git-pair needs to be installed under system ruby
```
sudo gem install ehrenmurdick-git-pair
```

- Quicksilver shows in dock (right-click, go to preferences, deselect 'show in dock')
- setup printer
- native scrolling for mouse
- keyboard keypress repeat delay
- setup local db
- Setup VirtualBox with a WindowsXP image - used for cross OS testing
- Boxen should prompt for devmac name and set it up accordingly

- these still need automating:
  * npm install -g coffee-script
  * DBVisualiser or PGAdmin
  * package control for sublime
  * Skype

- Unable to run `./script/boxen` OR `git push` when logged into a devmac over an ssh connection. Boxen has a problematic relationship with the OSX keychain, causing ssh authentication woes:
```
$ ssh devmac-8
Last login: Mon Jun 24 14:51:05 2013 from devs-imac.au.lpint.net
(devmac-8) (14:54:41) ~ 'Sacha Chua' 1.9.3p392
$
$ ./script/boxen
Successfully installed bundler-1.3.5
1 gem installed
Boxen Keychain Helper: Encountered error code: -25308
Error: User interaction is not allowed.
Boxen Keychain Helper: Encountered error code: -25308
Error: User interaction is not allowed.
--> Hey, I need your current GitHub credentials to continue.

GitHub login: |sppdev|
GitHub password: ********
Boxen Keychain Helper: Encountered error code: -25308
Error: User interaction is not allowed.
Boxen Keychain Helper: Encountered error code: -25308
Error: User interaction is not allowed.
```


## Troubleshooting

**Christo fails to fetch places and manifests?**

Most likely an issue with your server. Hit atlas.local/server-info to get more information

**Getting a Postgres error like** `PG::Error: ERROR: relation "geometry_columns" does not exist` **?**

Postgis has not been setup correctly. Inspect the log `/tmp/boxen/postgis.out` and ensure the script (`/tmp/boxen/create_postgis_template.sql`) points to the correct `/postgis.sql` and `/spatial_ref_sys.sql`.
It should look like (path may vary)

```sql
\i /opt/boxen/homebrew/Cellar/postgresql/9.1.9-ocboxen/share/postgresql/contrib/postgis-1.5/postgis.sql
\i /opt/boxen/homebrew/Cellar/postgresql/9.1.9-ocboxen/share/postgresql/contrib/postgis-1.5/spatial_ref_sys.sql
```
