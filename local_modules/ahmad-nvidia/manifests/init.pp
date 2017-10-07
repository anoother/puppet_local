# == Class: nvidia
#
# Full description of class nvidia here.
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
#  class { 'nvidia':
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
class nvidia {

require apt

  apt::source { 'cuda':
    location     => 'http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64',
    repos        => '/',
    release      => ' ',
    include      => {
      'deb' => true,
      'src' => false,
    },
    key           => {
      'id'  => 'AE09FE4BBD223A84B2CCFCE3F60F4B3D7FA2AF80',
      'url' => 'http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/7fa2af80.pub',
    },
      before =>  Exec['apt_update'],
  } ->

  apt::pin { 'nvidia':
    originator => "NVIDIA",
    priority   => 501,
  } ->

  package {[
    'nvidia-384-dev',
    'cuda-9-0',
    'cuda-toolkit-9-0',
  ]: ensure => present,
  } ~>

  package { [
    'nvidia-prime',
    'bbswitch-dkms'
  ]:
    ensure => purged,
  }

  ## Need to be cleverer about the following... only if we have docker, etc etc.

  define nvidia_github_repo {
    apt::source { "nvidia-$title":
      location     => "https://nvidia.github.io/$title/ubuntu16.04/amd64",
      repos        => '/',
      release      => ' ',
      include      => {
        'deb' => true,
        'src' => false,
      },
      key           => {
        'id'     => 'C95B321B61E88C1809C4F759DDCAE044F796ECB0',
        'source' => 'https://nvidia.github.io/nvidia-docker/gpgkey',
      },
        before =>  Exec['apt_update'],
    }
  }

  nvidia_github_repo { [
    'libnvidia-container',
    'nvidia-container-runtime',
    'nvidia-docker',
  ]: } ->

  package { 'nvidia-docker2': ensure => present, }

}
