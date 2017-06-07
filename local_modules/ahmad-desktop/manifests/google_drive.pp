class desktop::google_drive {

  apt::ppa { 'ppa:alessandro-strada/ppa':
    before => Exec['apt_update'],
  } ->

  package { 'google-drive-ocamlfuse':
      ensure  => present,
      require => Exec['apt_update'],
  }

}
