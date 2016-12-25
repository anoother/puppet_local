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
  package { [
    'apport-gtk',
    'apport-kde',
  ]:
    ensure => purged,
  }

}
