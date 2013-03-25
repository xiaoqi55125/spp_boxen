# Set up pow to work with rbenv
class pow::rbenv {
  include pow

  $home = "/Users/${::luser}"

  file { "${home}/.powconfig":
    content => template("pow/powconfig.erb"),
    require => [Package["pow"], Package["rbenv"]]
  }

  file { "${home}/.rbenv":
    target => "`rbenv root`",
    ensure => "link"
  }
}
