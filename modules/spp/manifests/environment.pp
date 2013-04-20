class spp::environment {

  include spp::applications
  include projects::atlas
  include projects::remixer
  include spp::config

  include spp::licenses # Split out so other users can use their own keys

}
