class desktop::fwupd {

  ### uuughh
  package { 'fwupd':
    ensure => purged,
  } ->

  file { '/var/lib/fwupd':
    ensure => absent,
    force => true,
  }

}
