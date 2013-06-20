## TODO

 - passenger config is added to httpd.conf but must still run installer manually. Must run

```bash
passenger-install-apache2-module
sudo apachectl restart
```
- git-pair is not installed under system ruby
```
sudo gem install ehrenmurdick-git-pair
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
