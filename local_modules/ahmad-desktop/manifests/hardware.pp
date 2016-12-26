class desktop::hardware {

  package {
    [
      'hdparm',
      'sdparm',
      'smartmontools',
      'laptop-mode-tools',
      'linux-tools-generic',
      'linux-tools-common',
      'lm-sensors',
      'powertop',
    ]: ensure => present
  }

  service { 'smartd':
    provider => 'systemd',
    ensure   => stopped,
    enable   => false,
    require  => Package['smartmontools'],
  }

  file_line { 'laptop_mode cpufreq':
    path    => '/etc/laptop-mode/conf.d/cpufreq.conf',
    line    => 'CONTROL_CPU_FREQUENCY=0',
    match   => 'CONTROL_CPU_FREQUENCY=',
    replace => true,
    require  => Package['laptop-mode-tools'],
  }

  file_line { 'laptop_mode pstate':
    path    => '/etc/laptop-mode/conf.d/cpufreq.conf',
    line    => 'CONTROL_INTEL_PSTATE=0',
    match   => 'CONTROL_INTEL_PSTATE=',
    replace => true,
    require  => Package['laptop-mode-tools'],
  }

  service { 'laptop-mode':
    provider => 'systemd',
    ensure   => running,
    enable   => true,
    require  => [
      Package['laptop-mode-tools'],
      File_line['laptop_mode cpufreq'],
      File_line['laptop_mode pstate'],
    ],
  }


}
