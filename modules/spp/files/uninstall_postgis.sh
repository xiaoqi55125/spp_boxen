#!/bin/bash -e

echo "Stopping PostgreSQL..."
launchctl unload /Library/LaunchDaemons/dev.postgresql.plist

if [ -x /usr/bin/automake ]; then
  echo "Removing old automake"
  rm /usr/bin/automake*
  rm /usr/bin/aclocal*
fi

if [ -x /usr/bin/autoconf ]; then
  echo "Removing old autoconf"
  rm /usr/bin/autoconf*
  rm /usr/bin/autoheader*
  rm /usr/bin/autom4te*
  rm /usr/bin/autoreconf*
  rm /usr/bin/autoscan*
  rm /usr/bin/autoupdate*
  rm /usr/bin/ifnames*
fi

echo "Uninstalling PostGIS and all of its dependencies..."
brew rm --force \
        postgis \
          automake \
            autoconf \
          gpp \
          postgresql \
            ossp-uuid \
          json-c \
          gdal \
            giflib \
            libgeotiff \
              lzlib \
            libspatialite \
              proj \
              geos \
              sqlite \
                readline \
              libxml2 \
              freexl

echo "Moving the data directory..."
rm -rf /opt/boxen/data/postgresql.bak
mv /opt/boxen/data/postgresql{,.bak}
