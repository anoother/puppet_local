class desktop::google {

  define google_apt_source() {
    apt::source { $name:
      location     => "http://dl.google.com/linux/${name}/deb/",
      repos        => 'main',
      release      => 'stable',
      architecture => 'amd64',
      include      => {
        'deb' => true,
        'src' => false,
      },
      key          => {
        'id' => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
      },
    }
  }

  google_apt_source { ['chrome', 'chrome-remote-desktop', ]: } ->

  package {
    [
      'google-chrome-stable',
      'chrome-remote-desktop',
    ]:
      ensure  => present,
      require => Exec['apt_update'],
  } ->

  file { '/etc/apt/sources.list.d/google-chrome.list':
    # Google provide inconsistent repo names in their packages :(
    ensure => absent
  }

}
