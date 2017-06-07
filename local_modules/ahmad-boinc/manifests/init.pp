class boinc {

  require apt

  package { [
    'boinc',
  ]:
    ensure => present,
  } ->

  service { 'boinc-client':
    enable => false,
  }

}
