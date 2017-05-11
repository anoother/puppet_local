class desktop::razer {

  apt::ppa { 'ppa:terrz/razerutils':
    before => Exec['apt_update'],
  } ->

  package { [
    'python3-razer',
    'razer-kernel-modules-dkms',
    'razer-daemon',
    'razer-doc',
  ]:
    ensure => present,
    require => Exec['apt_update'],
  }

}
