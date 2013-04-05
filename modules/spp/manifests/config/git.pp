class config::git {

  package { ["edgecase-git-pair"]:
    ensure => installed,
    provider => "gem",
  }

  file { "/Users/${::luser}/.gitconfig":
    content => "
[hub]
  protocol = https

[credential]
  helper = /opt/boxen/bin/boxen-git-credential

[core]
  excludesfile = /opt/boxen/config/git/gitignore
  editor = subl -w

[color]
  diff = auto
  status = auto
  branch = auto
  ui = true

[push]
  default = simple

[git-pair]
  authors = Jonathan Ricketson <jonathanr@lonelyplanet.com.au>
  authors = Duncan Warnock <duncan.warnock@lonelyplanet.com.au>
  authors = David Hodges <david.hodges@lonelyplanet.com.au>
  authors = Matt Riddle <matthew.riddle@lonelyplanet.com.au>
  authors = Adel Smee <adel.smee@lonelyplanet.com.au>
  authors = James Holmes <james.holmes@lonelyplanet.com.au>
  authors = Ben Galvin <ben.galvin@lonelyplanet.com.au>
  authors = Tim Moore <tim.moore@lonelyplanet.com.au>
[user]
  name =
  email =
    ",
    require => Package['boxen/brews/git'],
  }


}
