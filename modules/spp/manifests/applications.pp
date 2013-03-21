class spp::applications {

  include iterm2::stable
  include gitx
  include wget
  include sublime_text_2
  include firefox
  include chrome
  include shiftit
  include xquartz

  package { "DbVisualizer":
    ensure => "present",
    provider => 'pkgdmg', 
    source => 'http://www.dbvis.com/form/registerDownload.jsp?prodid=73&product=DbVisualizer&version=9.0.5&version_type=current&target_os=mac&with_jre=false&filename=dbvis_macos_9_0_5.dmg&type=Mac+OS+X+(installer)&installer=%2fproduct_download%2fdbvis-9.0.5%2fmedia%2fdbvis_macos_9_0_5.dmg'
  }

  package { "Quicksilver":
    ensure => "present",
    provider => 'appdmg',
    source => 'https://github.com/downloads/quicksilver/Quicksilver/Quicksilver%20B70.dmg',
  }

}
