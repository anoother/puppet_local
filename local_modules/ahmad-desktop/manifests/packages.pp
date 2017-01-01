class desktop::packages {

  apt::ppa {
    [
      'ppa:audacity-team/daily',
      'ppa:hda-me/qt5ct',
      'ppa:pmjdebruijn/darktable-release',
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

  apt::source { 'vivaldi':
    location => 'http://repo.vivaldi.com/stable/deb',
    repos    => 'main',
    release  => 'stable',
    include  => {
      'deb' => true,
      'src' => false,
    },
    key      => {
      'id'     => 'CBAD9CC076BDAF25B2809096CEC384A8BF1700F8',
      'source' => 'http://repo.vivaldi.com/stable/vivaldi_signing_key.pub',
    }
  } ->

  package {[
    'vivaldi-stable',
    'vivaldi-snapshot',
  ]:
      ensure  => present,
      require => Exec['apt_update'],
  }

  package {
    [
      'audacity',
      'blender',
      'build-essential',
      'chromium-browser',
      'darktable',
      'dcfldd',
      'dzen2',
      'gimp',
      'gimp-gmic',
      'git',
      'herbstluftwm',
      'htop',
      'libffi-dev',
      'libssl-dev',
      'libxml2-dev',
      'libxslt1-dev',
      'meld',
      'network-manager-openconnect-gnome',
      'pandoc',
      'python-demjson', # jsonlint-py
      'python-dev',
      'puppet-lint',
      'stow',
      'texlive-fonts-recommended', # For pandoc
      'tig',
      'tree',
      'unison',
      'vagrant',
      'vagrant-lxc',
      'vim',
      'virtualenvwrapper',
      'wkhtmltopdf', # For pandoc
      'xclip',
      'xmonad',
    ]:
      ensure  => present,
      require => Exec['apt_update'],
  }

}
