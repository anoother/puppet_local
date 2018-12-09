class laptop {

  require apt
  require udev

  include laptop::hardware
  include laptop::hibernate
  include laptop::powersave
  #include laptop::razer

}
