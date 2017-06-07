class initram::update {

  require initram
  
  exec { $initram::rebuild_command:
    path     => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
    provider => 'shell', # update-initramfs is a shell script
  }

}
