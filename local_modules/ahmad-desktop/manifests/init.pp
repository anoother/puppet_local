class desktop {

  require apt

  include desktop::fwupd

  apt::ppa {
    [
      'ppa:audacity-team/daily',
      'ppa:hda-me/qt5ct',
      'ppa:scribus/ppa',
      'ppa:thomas-schiex/blender',
    ]:
  }

  apt::source { 'steam':
    location     => 'http://repo.steampowered.com/steam/',
    repos        => 'steam',
    release      => 'precise',
    architecture => 'amd64,i386',
    include      => {
      'deb' => true,
      'src' => true,
    },
    key          => {
      'id' => 'BA1816EF8E75005FCF5E27A1F24AEA9FB05498B7',
    },
  }

  apt::source { 'nodesource':
    location => 'https://deb.nodesource.com/node_5.x/',
    repos    => 'main',
    release  => 'xenial',
    include  => {
      'deb' => true,
      'src' => true,
    },
    key      => {
      'id' => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
    },
  }

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
  google_apt_source { ['chrome', 'chrome-remote-desktop', ]: }

  package {
    [
      'xmonad',
      'htop',
      'stow',
      'tree',
      'dmenu',
      'dzen2',
      'git',
      'virtualenvwrapper',
      'dcfldd',
      'tig',
      'vim',
      'pandoc',
      'texlive-fonts-recommended', # For pandoc
      'wkhtmltopdf', # For pandoc
      'lm-sensors',
      'puppet-lint',
      'steam',
      'google-chrome-stable',
      'chromium-browser',
      'chrome-remote-desktop',
      'audacity',
    ]:
      ensure  => present,
      require => Exec['apt_update'],
  }

}
