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
    ]: ensure => present
  }

}
