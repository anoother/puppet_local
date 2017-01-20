class desktop::virtualbox {

  apt::source { 'virtualbox':
    location => 'http://download.virtualbox.org/virtualbox/debian',
    repos    => 'contrib',
    release  => 'xenial',
    include  => {
      'deb' => true,
      'src' => false,
    },
    key      => {
      'id'     => 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF',
      'source' => 'https://www.virtualbox.org/download/oracle_vbox_2016.asc',
    }
  } ->

  package {[
    'virtualbox',
    'virtualbox-guest-additions-iso',
    'virtualbox-qt',
    'virtualbox-source',
    #'virtualbox-ext-pack', # Need to accept the license manually
  ]:
    ensure  => present,
    require => Exec['apt_update'],
  }

  package {[
    'virtualbox-guest-utils',
    'virtualbox-guest-x11',
  ]:
    ensure  => purged
  }

}
