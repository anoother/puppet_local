class desktop::packages {

  apt::ppa { [
    'ppa:freecad-maintainers/freecad-stable',
    'ppa:freecad-maintainers/freecad-daily',
    'ppa:audacity-team/daily',
    'ppa:hda-me/qt5ct',
    'ppa:obsproject/obs-studio',
    'ppa:pmjdebruijn/darktable-release',
    'ppa:scribus/ppa',
    'ppa:thomas-schiex/blender',
    'ppa:ubuntu-mozilla-daily/ppa',
    'ppa:wereturtle/ppa',
    'ppa:jon-hedgerows/get-iplayer',
    'ppa:ethereum/ethereum',
  ]: before =>  Exec['apt_update'], 
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
      before =>  Exec['apt_update'], 
  }

  apt::source { 'nodesource':
    location => 'https://deb.nodesource.com/node_11.x/',
    repos    => 'main',
    release  => 'bionic',
    include  => {
      'deb' => true,
      'src' => true,
    },
    key      => {
      'id' => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
    },
  }

  #apt::source { 'sur5r-i3':
  #  location => 'http://debian.sur5r.net/i3/',
  #  repos    => 'universe',
  #  release  => 'bionic',
  #  include  => {
  #    'deb' => true,
  #    'src' => true,
  #  },
  #  key      => {
  #    'id' => 'baa43dbbd7232ea2b5444cae238d53bebb9d34601cc000e82f11111b1889078a',
  #  },
  #}

  #apt::source { 'vivaldi':
  #  location => 'http://repo.vivaldi.com/stable/deb',
  #  repos    => 'main',
  #  release  => 'stable',
  #  include  => {
  #    'deb' => true,
  #    'src' => false,
  #  },
  #  key      => {
  #    'id'     => 'CBAD9CC076BDAF25B2809096CEC384A8BF1700F8',
  #    'source' => 'http://repo.vivaldi.com/stable/linux_signing_key.pub',
  #  }
  #} ->

  package { [
    'vivaldi-stable',
    'vivaldi-snapshot',
  ]:
      ensure  => present,
      require => Exec['apt_update'],
  }

  $pdf_packages = [
    'libbatik-java',
    'xpaint',
    'texlive-pstricks',
    'texlive-font-utils',
    'libgxps-utils',
    'mupdf-*',
  ]
  package { $pdf_packages:
      ensure => present,
      require => Exec['apt_update'],
  }

  package { [
      'acpi',
      'audacity',
      #'beignet', # Blender doesn't like multiple OpenCL ICDs. Fix properly later.
      'blender',
      'build-essential',
      'chromium-browser',
      'cloc',
      'darktable',
      'dcfldd',
      'dmenu',
      'dzen2',
      'firefox-trunk',
      'firefox-trunk-globalmenu',
      'firefox-trunk-locale-en',
      'get-iplayer',
      'ghostwriter',
      'gimp',
      'gimp-gmic',
      'git',
      'gparted',
      'gwenview',
      'heimdall-flash-frontend',
      'herbstluftwm',
      'htop',
      'i3',
      'inkscape',
      'iotop',
      'ipython',
      'kwrite',
      'libffi-dev',
      'libpq-dev',
      'libqt4-dev',
      'libssl-dev',
      'libxcb-randr0-dev', # For lemonbar compilation
      'libxcb-xinerama0-dev', # For lemonbar compilation
      'libxml2-dev',
      'libxslt1-dev',
      'links',
      'markdown',
      'meld',
      'mercurial',
      'mesa-utils', # For glxgears
      'mtp-tools',
      'network-manager-openconnect-gnome',
      'nmap',
      'obs-studio',
      'pandoc',
      'pavucontrol',
      'playonlinux',
      'pnmixer',
      'puppet-lint',
      'python-demjson', # jsonlint-py
      'python-dev',
      'qt4-qmake',
      'sakura',
      'screen',
      'scribus',
      'sloccount',
      'stow',
      'stress',
      'tig',
      'tmux',
      'tree',
      'unison',
      'units',
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

  package { [
    'gnome-screensaver' # Presents a second login screen on resume
  ]:
    ensure => absent
  }

}
