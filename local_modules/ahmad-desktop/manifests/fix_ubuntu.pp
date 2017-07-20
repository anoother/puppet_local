class desktop::fix_ubuntu {
  # Fix Ubuntu Brokenness

  # Uuughh
  package { 'fwupd':
    ensure => purged,
  } ->
  file { '/var/lib/fwupd':
    ensure => absent,
    force  => true,
  }

  # Disable DNS proxy
  file_line { 'disable_dns_proxy':
    path   => '/etc/NetworkManager/NetworkManager.conf',
    line   => 'dns=dnsmasq',
    ensure => 'absent',
  }

  # Disable Amazon advertising
  file { '/usr/share/applications/ubuntu-amazon-default.desktop':
    ensure => absent,
  }

  # Disable crash reporter
  package { 'apport': ensure => purged }

  # Remove Ubuntu Software Centre
  package { 'ubuntu-software': ensure => purged }

  # Disable thermald on non-Intel CPUs
  if 'Intel' in $::processor0 {
    service { 'thermald':
      provider => 'systemd',
      ensure   => running,
      enable   => true,
    }
  } else {
    service { 'thermald':
      provider => 'systemd',
      ensure   => stopped,
      enable   => false,
    }
  }

  # Eats CPU for no gain
  package { 'apt-xapian-index': ensure => absent }

  # Firefox addon that stop multiprocess working
  package { 'xul-ext-ubufox': ensure => absent }

  # This lets keyboard shortcuts work in qt5 apps. Disables the ubuntu menu for them, though
  # https://bugs.launchpad.net/ubuntu/+source/appmenu-qt5/+bug/1313248
  package { 'appmenu-qt5': ensure => absent }

  # Spying:
  package { 'popularity-contest': ensure => absent }

  file { '/etc/udev/rules.d/70-u2f.rules':
    source => "puppet:///modules/${caller_module_name}/70-u2f.rules",
    owner  => root,
    group  => root,
    mode   => 0644,
  } ~> Class['udev::udevadm::trigger']

}
