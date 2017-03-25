# == Class: opal
#
# Full description of class opal here.
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
#  class { 'opal':
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

class opal {

  file_line { 'allow_tpm':
    path => '/etc/default/grub',
    line => 'GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT libata.allow_tpm=1"'
  } ~>
  exec { '/usr/sbin/update-grub':  refreshonly => true } ~>
  exec { '/usr/sbin/grub-install': refreshonly => true}

  $sedutil_archive = 'sedutil_LINUX.tgz'
  $sedutil_url = 'https://github.com/Drive-Trust-Alliance/exec/blob/master'
  $sedutil_install_path = '/usr/local/sbin'

  archive { "/tmp/$sedutil_archive":
    # This is really no better than an exec. Add file selection support to the archive module.
    url             => "${sedutil_url}/${sedutil_archive}?raw=true",
    extract         => true,
    extract_path    => $sedutil_install_path,
    extract_command => 'tar xvf %s sedutil/Release_x86_64/GNU-Linux/sedutil-cli --strip-components=3',
    checksum_type   => 'sha256',
    checksum        => '15b28d0441e7cfa2a317aca36d4360c93b6821ca9d026a5c4b50096d0b931a2e',
    cleanup         => true,
    creates         => "${sedutil_install_path}/sedutil-cli"
  } ->

  file { "${sedutil_install_path}/sedutil-cli":
    mode => '0755'
  }

  define systemd_mask() {
    file { $name:
      path   => "/etc/systemd/system/${name}",
      ensure => 'link',
      target => '/dev/null'
    }
  }

  ## Disable sleep because it's not supported...
  #systemd_mask { [
  #  'sleep.target',
  #  'suspend.target',
  #  'hybrid-sleep.target'
  #]: }

  file { '/etc/polkit-1/localauthority/50-local.d/com.ubuntu.disable-suspend.pkla':
    source => "puppet:///modules/${name}/com.ubuntu.disable-suspend.pkla"
  }

}