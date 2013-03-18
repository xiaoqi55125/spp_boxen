class spp::config {

  file { "iTerm2 Preferences":
      path => "/Users/${::luser}/Library/Preferences/com.googlecode.iterm2.plist",
      source  => "puppet:///modules/spp/com.googlecode.iterm2.plist",
  }
  
}