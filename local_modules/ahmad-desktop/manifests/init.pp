class desktop {
	package {[
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
    'vim-enhanced',
    'pandoc',
    'texlive-fonts', # For pandoc
    'wkhtmltopdf', # For pandoc
	]: ensure => installed
	}	
}
