define initram::module($ensure = 'present') {

  require initram
  include initram::update

  $modules_file = $initram::modules_file
  $m_line_prefix = $initram::m_line_prefix
  $m_line_suffix = $initram::m_line_suffix

  file_line { "initram_module_${title}":
    ensure            => $ensure,
    line              => "${m_line_prefix}${title}${m_line_suffix}",
    match             => $title,
    replace           => false,
    match_for_absence => true,
    path              => $modules_file,
    notify            => Class['initram::update']
  }

}
