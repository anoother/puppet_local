class desktop::audio {

  file { '/etc/pulse/gsx1000.conf':
    source => "puppet:///modules/${caller_module_name}/gsx1000.conf",
    owner  => root,
    group  => root,
    mode   => 0644,
  } ->

  file { '/etc/udev/rules.d/90-gsx1000.rules':
    content => 'ATTRS{manufacturer}=="Sennheiser", ATTRS{product}=="GSX 1000 Main Audio", ENV{PULSE_PROFILE_SET}="/etc/pulse/gsx1000.conf"',
    owner   => root,
    group   => root,
    mode    => 0644,
  } ~> Class['udev::udevadm::trigger']

}
