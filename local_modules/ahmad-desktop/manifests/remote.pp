class desktop::remote {
  # Remote access tools

  service { 'teamviewerd':
    provider => 'systemd',
    ensure   => stopped,
    enable   => false,
  }
}
