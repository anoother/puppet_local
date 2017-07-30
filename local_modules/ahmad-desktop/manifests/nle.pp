class desktop::nle {

  apt::ppa { [
    'ppa:cinelerra-ppa/ppa',
    'ppa:haraldhv/shotcut',
    'ppa:rebuntu16/avidemux+unofficial',
  ]: before =>  Exec['apt_update'], 
  }

  apt::source { 'lumiera':
    location => 'http://lumiera.org/debian/',
    repos    => 'experimental',
    release  => 'xenial',
    include  => {
      'deb' => true,
      'src' => true,
    },
    key      => {
      'id' => 'D0333C21252B66D54A4CC1D265B66B07A1DE94B2',
    },
  }


  package { [
      'avidemux2.6-qt5',
      'cinelerra-cv',
      'kdenlive',
      'lives',
      'lumiera',
      'openshot',
      'pitivi',
      'shotcut',
    ]:
      ensure  => present,
      require => Exec['apt_update'],
  }

}
