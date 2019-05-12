class desktop::fonts {

  package { [
      'fonts-droid-fallback',
      'fonts-font-awesome',
      'fonts-sil-gentium*',
      'texlive-fonts-recommended', # For pandoc
      'ttf-dejavu-extra',
      'unifont',
      'xfonts-jmk',
      'xfonts-terminus',
    ]:
      ensure  => present,
      require => Exec['apt_update'],
  }

  file { '/etc/fonts/conf.d/10-sub-pixel-rgb.conf':
    ensure => link,
    target => '/etc/fonts/conf.avail/10-sub-pixel-rgb.conf',
  }

}


