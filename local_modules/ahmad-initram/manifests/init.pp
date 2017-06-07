# == Class: initram
#
# Full description of class initram here.
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
#  class { 'initram':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <ahmadjagot@gmail.com>
#
# === Copyright
#
# Copyright 2017 Ahmad Jagot, unless otherwise noted.
#
class initram {

  case $::osfamily {
    'Redhat': {
      $modules_file = '/etc/dracut.conf'
      $m_line_prefix = 'add_drivers+="'
      $m_line_suffix = '"'
      $rebuild_command = 'dracut -f'
    }
    'Debian': {
      $modules_file = '/etc/initramfs-tools/modules'
      $m_line_prefix = ''
      $m_line_suffix = ''
      $rebuild_command = 'update-initramfs -u'
    }
    default: {}
  }

}

