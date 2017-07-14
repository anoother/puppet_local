# == Class: autogpu
#
# Full description of class autogpu here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'autogpu':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class autogpu {

  file { '/etc/multigpu.snippets':
    ensure => absent,
  }
  file { '/usr/local/sbin/multigpu':
    ensure => absent,
  }
  service { 'multigpu':
    ensure => stopped,
  } ->
  file { '/etc/systemd/system/multigpu.service':
    ensure => absent,
  } ->
  file { '/etc/X11/xorg.conf.d/09-multigpu.conf':
    ensure => absent,
  }

  file { '/etc/X11/xorg.conf.d/01-amdgpu-pro-px.conf':
    ensure => absent,
  }

  file { '/etc/autogpu.snippets':
    source => "puppet:///modules/${module_name}/autogpu.snippets.example",
    owner  => 'root',
    group  => 'root',
    notify => Service['autogpu'],
  }

  file { '/usr/local/sbin/autogpu':
    source => "puppet:///modules/${module_name}/autogpu",
    owner  => 'root',
    group  => 'root',
    notify => Service['autogpu'],
  }

  file { '/usr/local/sbin/update-nvidia-alternatives':
    source => "puppet:///modules/${module_name}/update-nvidia-alternatives",
    owner  => 'root',
    group  => 'root',
    notify => Service['autogpu'],
  }


  file { '/etc/systemd/system/autogpu.service':
    source => "puppet:///modules/${module_name}/autogpu.service",
    owner  => 'root',
    group  => 'root',
    notify => Service['autogpu'],
  }

  service { 'autogpu':
    enable   => true,
    ensure   => running,
    provider => systemd,
  }

}
