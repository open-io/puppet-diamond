define diamond::collector (
  $enabled = true,
) {

  include ::diamond

  if is_string($title) { $collector_names = split($title,',') }
  elsif is_array($title) { $collector_names = $title }
  else { fail('Title should be an array or a string.') }

  $_collector_names = suffix(prefix($collector_names,"${::diamond::collectors_config_path}/"),'.conf')

  file {$_collector_names:
    ensure  => $::diamond::file_ensure,
    content => template('diamond/collectors/default.conf.erb'),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
  }

}
