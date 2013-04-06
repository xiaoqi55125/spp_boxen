class people::mriddle::config {

  git::config::global{ 'user.name':
    value => 'Matthew Riddle',
  }

  git::config::global{ 'user.email':
    value => 'mriddle89@gmail.com',
  }

  git::config::global { 'alias.lg':
    value => "log --pretty=format:'%C(yellow)%h%C(reset) %s %C(cyan)%cr%C(reset) %C(blue)%an%C(reset) %C(green)%d%C(reset)' --graph --date-order",
  }

}
