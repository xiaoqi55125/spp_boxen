#!/bin/bash -e

echo "Stopping PostgreSQL..."
launchctl unload /Library/LaunchDaemons/dev.postgresql.plist

echo "Uninstalling PostGIS and all of its dependencies..."
brew rm postgis \
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
