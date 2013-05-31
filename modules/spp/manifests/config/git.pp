class config::git {

  ruby::gem { "1.9.3 edgecase-git-pair":
    gem => 'edgecase-git-pair',
    ruby => '1.9.3'
  }

  git::config::global{ 'alias.lg':
    value => "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --branches --remotes --tags",
  }

  git::config::global{ 'color.ui':
    value => 'auto',
  }

  git::config::global{ 'core.editor':
    value => 'subl -w',
  }

  git::config::global{ 'branch.autosetuprebase':
    value => 'always',
  }

  define add_git_pair ($user_details = $title) {
    exec {"Add ${user_details} git pair":
      command => "git config --global --add git-pair.authors \"${user_details}\"",
      unless => "grep -c \"${user_details}\" /Users/${::luser}/.gitconfig"
    }
  }

  add_git_pair{"Jonathan Ricketson <jonathanr@lonelyplanet.com.au>":}
  add_git_pair{"David Hodges <david.hodges@lonelyplanet.com.au>":}
  add_git_pair{"Matt Riddle <matthew.riddle@lonelyplanet.com.au>":}
  add_git_pair{"Adel Smee <adel.smee@lonelyplanet.com.au>":}
  add_git_pair{"James Holmes <james.holmes@lonelyplanet.com.au>":}
  add_git_pair{"Ben Galvin <ben.galvin@lonelyplanet.com.au>":}
  add_git_pair{"Tim Moore <tim.moore@lonelyplanet.com.au>":}
  add_git_pair{"Luke Robins <luke.robins@lonelyplanet.com.au>":}
  add_git_pair{"Daniel Corbett <daniel.corbett@lonelyplanet.com.au>":}

}
