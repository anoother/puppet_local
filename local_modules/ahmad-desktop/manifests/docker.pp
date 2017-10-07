class desktop::docker {

  apt::source { 'docker':
    location     => 'https://download.docker.com/linux/ubuntu',
    repos        => 'stable',
    release      => 'xenial',
    architecture => 'amd64',
    include      => {
      'deb' => true,
      'src' => false,
    },
    key          => {
      'id'     => '9DC858229FC7DD38854AE2D88D81803C0EBFCD88',
      'source' => 'https://download.docker.com/linux/ubuntu/gpg',
    }
  } ->

  apt::pin { 'docker':
    originator => "Docker",
    priority   => 501,
  } ->

  package { 'docker-ce':
    ensure  => present,
    require => Exec['apt_update'],
  }

  package { [
    'docker',
    'docker.io',
  ]:
    ensure => purged,
  }

  #file { [
  #  '/etc/apparmor.d/tunables/home',
  #  '/etc/apparmor.d/tunables/proc',
  #]:
  #    ensure => present,
  #}

}
