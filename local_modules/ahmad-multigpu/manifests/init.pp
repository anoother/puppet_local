# == Class: multigpu
#
# Full description of class multigpu here.
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
#  class { 'multigpu':
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
class multigpu {

  file { '/etc/X11/xorg.conf.d/01-amdgpu-pro-px.conf':
    ensure => absent,
  }

  file { '/etc/multigpu.snippets':
    source => "puppet:///modules/${module_name}/multigpu.snippets.example",
    owner  => 'root',
    group  => 'root',
  }

  file { '/usr/local/sbin/multigpu.sh':
    source => "puppet:///modules/${module_name}/multigpu.sh",
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/systemd/system/multigpu.service':
    source => "puppet:///modules/${module_name}/multigpu.service",
    owner  => 'root',
    group  => 'root',
  }

}
