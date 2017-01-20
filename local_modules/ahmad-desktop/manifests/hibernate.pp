class desktop::hibernate {

  # Swap is used only for hibernate:
  sysctl { 'vm.swappiness': value => '0' }

  # Not sure if this is necessary...
  file { '/etc/initramfs-tools/conf.d/resume':
    content => "RESUME=${::swap_device}\n",
    owner  => 'root',
    group  => 'root'
  } ~>

  exec { 'update-initramfs -u':
    provider => 'shell' # update-initramfs is a shell script
  }

  #file_line { 'grub_resume':
  #  path    => '/etc/default/grub',
  #  line    => "GRUB_CMDLINE_LINUX_DEFAULT=\"\$GRUB_CMDLINE_LINUX_DEFAULT resume=${::swap_device}\""
  #  #require => Exec['update-initramfs -u']
  #} # This needs to notify grub

  file { '/etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla':
    source => "puppet:///modules/${caller_module_name}/com.ubuntu.enable-hibernate.pkla"
  }

  file { '/etc/systemd/logind.conf':
    source => "puppet:///modules/${caller_module_name}/logind.conf",
    owner  => 'root',
    group  => 'root'
  } ~>

  service {'logind': provider => 'systemd' }

}
