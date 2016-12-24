class desktop::xorg {

  package { [
    'xserver-xorg-input-libinput',
    'libinput-tools',
  ]:
    ensure => present,
  } ->

  file { '/etc/X11/xorg.conf.d':
    ensure => directory,
  } ->

  file { '/etc/X11/xorg.conf.d/50-mouse.conf':
    source => "puppet:///modules/${caller_module_name}/50-mice.conf",
  }

}
