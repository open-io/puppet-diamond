class diamond::collectors::smart (
  $collector_name         = 'SmartCollector',
  $enabled                = true,
  $bin                    = undef,
  $byte_unit              = undef,
  $devices                = undef,
  $measure_collector_time = undef,
  $metrics_blacklist      = undef,
  $metrics_whitelist      = undef,
  $sudo_cmd               = undef,
  $use_sudo               = undef,
) inherits ::diamond::params {

  include ::diamond

  ensure_packages('smartmontools')

  file {"${::diamond::collectors_config_path}/${collector_name}.conf":
    ensure  => $::diamond::file_ensure,
    content => template('diamond/collectors/smart.conf.erb'),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
    require => Package['smartmontools'],
  }

}
