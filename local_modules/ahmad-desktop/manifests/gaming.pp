class desktop::gaming {

  package { [
    'pcsxr',
    'pcsx2',
  ]: ensure => present,
  }

}
