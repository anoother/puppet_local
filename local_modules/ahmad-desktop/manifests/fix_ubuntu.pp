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

  # Disable thermald
  service { 'thermald':
    provider => 'systemd',
    ensure   => stopped,
    enable   => false,
  }

  # Firefox addon that stop multiprocess working
  package { 'xul-ext-ubufox': ensure => absent }

  # This lets keyboard shortcuts work in qt5 apps. Disables the ubuntu menu for them, though
  # https://bugs.launchpad.net/ubuntu/+source/appmenu-qt5/+bug/1313248
  package { 'appmenu-qt5': ensure => absent }

}
