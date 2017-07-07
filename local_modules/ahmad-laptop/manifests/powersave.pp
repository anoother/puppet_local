class laptop::powersave {

  sysctl { 'vm.laptop_mode': value => '5' }

  sysctl { 'kernel.nmi_watchdog': value => '0' }

  file { '/usr/local/sbin/acdc':
    source => "puppet:///modules/${caller_module_name}/acdc.sh",
    owner  => root,
    group  => root,
    mode   => 0744,
  } ->

  file { '/etc/udev/rules.d/80-powersave.rules':
    source => "puppet:///modules/${caller_module_name}/80-powersave.rules",
    owner  => root,
    group  => root,
    mode   => 0644,
  } ~> Class['udev::udevadm::trigger']

}
