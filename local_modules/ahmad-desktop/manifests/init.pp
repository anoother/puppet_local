class desktop {

  require apt

  include desktop::fix_ubuntu
  include desktop::google
  include desktop::packages
  include desktop::xorg

  file { '/etc/puppet/puppet.conf':
    source => "puppet:///modules/${name}/puppet.conf",
    owner  => 'root',
    group  => 'root',
  }

  service { 'puppet':
    provider => 'systemd',
    ensure   => stopped,
    enable   => false,
  }

}
