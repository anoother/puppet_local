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
    'atmi',
    'compute-firmware',
    'cxlactivitylogger',
    'hcc',
    'hcfft',
    'hip_base',
    'hip_doc',
    'hip_hcc',
    #'hip_nvcc',
    'hip_samples',
    'hipblas',
    'hsa-amd-aqlprofile',
    'hsa-ext-rocr-dev',
    'hsa-rocr-dev',
    'hsakmt-roct',
    'hsakmt-roct-dev',
    #'miopen-hip',
    'miopen-opencl',
    'miopengemm',
    'rocblas',
    'rock-dkms',
    'rocm-clang-ocl',
    'rocm-dev',
    'rocm-device-libs',
    'rocm-dkms',
    'rocm-libs',
    'rocm-opencl',
    'rocm-opencl-dev',
    'rocm-profiler',
    'rocm-smi',
    'rocm-utils',
    'rocminfo',
    'rocrand',
  ]:
    ensure  => present,
  }

  file { '/etc/profile.d/rocm.sh':
    content => 'export PATH="$PATH:/opt/rocm/bin"',
  }

  file { '/usr/share/libdrm':
     ensure => directory,
  }
  file { '/usr/share/libdrm/amdgpu.ids':
    source => "puppet:///modules/${module_name}/amdgpu.ids",
  }

  kernel_parameter { 'amdgpu.vm_fragment_size':
    value    => '9',
    bootmode => 'default',
  }

}
