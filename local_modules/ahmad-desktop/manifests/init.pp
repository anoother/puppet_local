class desktop {

  require apt

  include desktop::fix_ubuntu
  include desktop::google
  include desktop::packages
  include desktop::xorg

}
