#!/usr/bin/env ruby

class Postgis153Installer

  # Hopefully there will be no need for all of this
  # when we upgrade to postgresql 9.2 / postgis 2.0
  # (i.e, because then we can use standard homebrew recipes)

  # helper for make_install
  class InstallDir
    def initialize dirname
      @dirname = dirname
    end

    def install files
      files.each {|f| exec "cp #{f} #{@dirname}"}
    end
  end

  def initialize
    @postgis_tarball_href = 'http://postgis.refractions.net/download/postgis-1.5.3.tar.gz'

    homebrew           = "/opt/boxen/homebrew"
    homebrew_postgres  = "#{homebrew}/Cellar/postgresql/9.1.9-ocboxen"
    @homebrew_postgis  = "#{homebrew}/Cellar/postgis/1.5.3"

    @bin               = InstallDir.new "#{homebrew}/bin"
    @postgresql_lib    = InstallDir.new "#{homebrew_postgres}/lib"
    @postgresql_share  = InstallDir.new "#{homebrew_postgres}/share"
    @postgis_sql       = InstallDir.new "#{homebrew_postgres}/share/postgis"
  end

  # -------------

  def install
    ensure_postgis_dir
    download_postgis
    configure
    make
    make_install
  end

  # -------------

  def ensure_postgis_dir
    exec "mkdir -p #{@homebrew_postgis}"
    exec "rm   -rf #{@homebrew_postgis}/*"
  end

  def download_postgis
    Dir.chdir '/tmp/boxen'
    exec "rm    -rf postgis-1.5.3"
    exec "curl   -o postgis-1.5.3.tar.gz #{@postgis_tarball_href}"
    exec "tar  zxvf postgis-1.5.3.tar.gz"
    exec "cp -rf    postgis-1.5.3/* #{@homebrew_postgis}"
  end

  def configure
    # see: https://github.com/mxcl/homebrew/wiki/Tips-N'-Tricks#install-into-homebrew-without-formulas

    Dir.chdir "#{@homebrew_postgis}"

    exec <<-SCRIPT
      ./configure --prefix=#{@homebrew_postgis} \
                  --disable-dependency-tracking \
                  --with-projdir=/opt/boxen/homebrew \
                  --with-pgconfig=/opt/boxen/homebrew/bin/pg_config;
    SCRIPT
  end

  def make
    exec 'make'
  end

  def make_install
    # -------------
    # mostly copied from homebrew postgis keg:
    # https://github.com/Homebrew/homebrew-versions/blob/b7eb2485a7ce34127a9710a327cc54fce7e2e3c1/postgis15.rb
    # -------------

    # __DON'T RUN MAKE INSTALL!__
    #
    # PostGIS includes the PGXS makefiles and so will install __everything__
    # into the Postgres keg instead of the PostGIS keg. Unfortunately, some
    # things have to be inside the Postgres keg in order to be function. So, we
    # install the bare minimum of stuff and then manually move everything else
    # to the prefix.

    # Install PostGIS plugin libraries into the Postgres keg so that they can
    # be loaded and so PostGIS databases will continue to function even if
    # PostGIS is removed.
    @postgresql_lib.install Dir['postgis/postgis*.so']

    # Stand-alone SQL files will be installed the share folder

    # Install version-specific SQL scripts and tools first. Some of the
    # installation routines require command line tools to still be present
    # inside the build prefix.
    @bin.install %w[
      loader/pgsql2shp
      loader/shp2pgsql
      utils/new_postgis_restore.pl
    ]

    # Install PostGIS 1.x upgrade scripts
    @postgis_sql.install %w[
      postgis/postgis_upgrade_13_to_15.sql
      postgis/postgis_upgrade_14_to_15.sql
      postgis/postgis_upgrade_15_minor.sql
    ]

    # Common tools
    @bin.install %w[
      utils/create_undef.pl
      utils/postgis_proc_upgrade.pl
      utils/postgis_restore.pl
      utils/profile_intersects.pl
      utils/test_estimation.pl
      utils/test_geography_estimation.pl
      utils/test_geography_joinestimation.pl
      utils/test_joinestimation.pl
    ]

    # Common SQL scripts
    @postgis_sql.install %w[
      spatial_ref_sys.sql
      postgis/postgis.sql
      postgis/uninstall_postgis.sql
    ]
  end

  def exec script
    puts script
    result = system script
    raise "#{$?}" if result.nil?
    puts result
  end
end

# only if this file is executed as a script
if __FILE__ == $0
  Postgis153Installer.new.install
end
