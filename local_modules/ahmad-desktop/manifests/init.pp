class desktop {

  require apt

  include desktop::fwupd
  include desktop::google
  include desktop::xorg

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

  package {
    [
      'audacity',
      'chromium-browser',
      'dcfldd',
      'dzen2',
      'git',
      'htop',
      'lm-sensors',
      'pandoc',
      'puppet-lint',
      'stow',
      'texlive-fonts-recommended', # For pandoc
      'tig',
      'tree',
      'vim',
      'virtualenvwrapper',
      'wkhtmltopdf', # For pandoc
      'xmonad',
    ]:
      ensure  => present,
      require => Exec['apt_update'],
  }

  file { '/usr/share/applications/ubuntu-amazon-default.desktop':
    ensure => absent,
  }

  package { [
    'apport-gtk',
    'apport-kde',
  ]:
    ensure => purged,
  }

}
