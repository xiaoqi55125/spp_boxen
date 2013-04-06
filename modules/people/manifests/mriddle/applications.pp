class people::mriddle::applications {
  include minecraft

  package { 'Github for Mac':
    source   => 'https://github-central.s3.amazonaws.com/mac%2FGitHub%20for%20Mac%20124.zip',
    provider => compressed_app
  }
}
