class vega {

require apt

  apt::ppa { 'ppa:paulo-miguel-dias/mesa':
    ensure => absent,
    before =>  Exec['apt_update'],
  }

  apt::ppa { 'ppa:oibaf/graphics-drivers':
    before =>  Exec['apt_update'],
  } ->

  package { [
    'xserver-xorg-video-amdgpu',
  ]:
    ensure  => present,
  }

  package { 'xserver-xorg-core-hwe-16.04':
    ensure  => purged,
    require => Apt::Ppa['ppa:oibaf/graphics-drivers'],
  }

  apt::source { 'rocm':
    location     => 'http://repo.radeon.com/rocm/apt/debian/',
    repos        => 'main',
    release      => 'xenial',
    architecture => 'amd64',
    include      => {
      'deb' => true,
      'src' => false,
    },
    key          => {
      'id'=>'CA8BB4727A47B4D09B4EE8969386B48A1A693C5C',
      'source' => 'http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key',
    },
      before =>  Exec['apt_update'],
  } ->

  package { [
    'compute-firmware',
  ]:
    ensure  => present,
  }

}
