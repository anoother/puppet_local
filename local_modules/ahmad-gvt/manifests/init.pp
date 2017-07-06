# == Class: gvt
#
# Full description of class gvt here.
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
#  class { 'gvt':
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
class gvt {

  initram::module { [
    'kvmgt',
    'vfio-iommu-type1',
    'vfio-mdev',
  ]: }

  kernel_parameter { [
    'i915.enable_gvt',
    'kvm.ignore_msrs',
  ]: value => 1 }

  package { [
    'qemu-kvm',
    'virt-manager',
  ]: } ->

  kmod::load { [
    'vfio-pci',
    'vfio-mdev',
  ]: }
  
}
