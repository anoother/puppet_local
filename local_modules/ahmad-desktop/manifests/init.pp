class desktop {

  include desktop::fwupd

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
    ]: ensure => installed
  }

}
