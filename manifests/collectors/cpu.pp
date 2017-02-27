class diamond::collectors::cpu (
  $collector_name         = 'CPUCollector',
  $enabled                = true,
  $measure_collector_time = undef,
  $metrics_blacklist      = undef,
  $metrics_whitelist      = undef,
  $normalize              = undef,
  $percore                = undef,
  $simple                 = undef,
) inherits ::diamond::params {

  include ::diamond

  file {"${::diamond::collectors_config_path}/${collector_name}.conf":
    ensure  => $::diamond::file_ensure,
    content => template('diamond/collectors/cpu.conf.erb'),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
  }

}
