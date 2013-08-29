-- Remove any existing template db
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE IF EXISTS template1;

-- Create a new database
CREATE DATABASE "template1" ENCODING = 'utf8' TEMPLATE = "template0";

-- Make it a template database
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';

-- Connect to new database and install the pl/pgsql language
\c template1

CREATE LANGUAGE plpgsql;

-- Install PostGIS
\i '/opt/boxen/homebrew/Cellar/postgis/1.5.3/postgis/postgis.sql';
\i '/opt/boxen/homebrew/Cellar/postgis/1.5.3/spatial_ref_sys.sql';

GRANT ALL ON geometry_columns TO PUBLIC;
GRANT ALL ON geography_columns TO PUBLIC;
GRANT ALL ON spatial_ref_sys TO PUBLIC;

-- vacuum freeze: it will guarantee that all rows in the database are
-- "frozen" and will not be subject to transaction ID wraparound
-- problems.
VACUUM FREEZE;