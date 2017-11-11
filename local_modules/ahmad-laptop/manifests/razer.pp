class laptop::razer {

  apt::ppa { [
    'ppa:terrz/razerutils',
  ]:
    ensure => absent,
    before => Exec['apt_update'],
  }

  apt::ppa { [
    'ppa:lah7/polychromatic',
  ]:
    before => Exec['apt_update'],
  } ->

  package { [
    'python3-razer',
    'razer-kernel-modules-dkms',
    'razer-daemon',
    'razer-doc',
    'polychromatic',
  ]:
    ensure => present,
    require => Exec['apt_update'],
  }

}
