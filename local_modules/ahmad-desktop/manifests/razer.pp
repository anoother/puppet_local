class desktop::razer {

  apt::ppa { [
    'ppa:terrz/razerutils',
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
