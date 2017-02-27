class diamond (
  $package_name           = $::diamond::params::package_name,
  $package_ensure         = $::diamond::params::package_ensure,
  $user                   = $::diamond::params::user,
  $user_ensure            = $::diamond::params::user_ensure,
  $group                  = $::diamond::params::group,
  $group_ensure           = $::diamond::params::group_ensure,
  $conf_dir               = $::diamond::params::conf_dir,
  $directory_ensure       = $::diamond::params::directory_ensure,
  $conf_file              = $::diamond::params::conf_file,
  $file_ensure            = $::diamond::params::file_ensure,
  $conf_template          = $::diamond::params::conf_template,
  $collectors_config_path = $::diamond::params::collectors_config_path,
  $collectors_path        = $::diamond::params::collectors_path,
  $handlers_config_path   = $::diamond::params::handlers_config_path,
  $handlers_path          = $::diamond::params::handlers_path,
  $service_name           = $::diamond::params::service_name,
  $service_enable         = $::diamond::params::service_enable,
  $service_manage         = $::diamond::params::service_manage,
  $service_ensure         = $::diamond::params::service_ensure,
  $service_restart        = $::diamond::params::service_restart,
  $handlers               = $::diamond::params::handlers,
  $pid_file               = $::diamond::params::pid_file,
  $collectors_load_delay  = $::diamond::params::collectors_load_delay,
  $metric_queue_size      = $::diamond::params::metric_queue_size,
  $collectors_default     = $::diamond::params::collectors_default,
  $loggers                = $::diamond::params::loggers,
  $formatters             = $::diamond::params::formatters,
  $logger_root            = $::diamond::params::logger_root,
  $handler_rotated_file   = $::diamond::params::handler_rotated_file,
  $formatter_default      = $::diamond::params::formatter_default,
  $configs                = $::diamond::params::configs,
) inherits ::diamond::params {

  package {$package_name:
    ensure => $package_ensure,
    name   => $package_name,
    notify => Class['Diamond::Service'],
  }

  user {$user:
    ensure => $user_ensure,
    gid    => $group,
    require => Package[$package_name],
  }

  group {$group:
    ensure => $group_ensure,
    require => Package[$package_name],
  }

  file { $conf_dir:
    ensure  => $directory_ensure,
    require => Package[$package_name],
  }

  file { "${::diamond::conf_dir}/${::diamond::params::conf_file}":
    ensure  => $file_ensure,
    content => template($conf_template),
    notify  => Class['Diamond::Service'],
    require => Package[$package_name],
  }

  file {[$collectors_config_path,$handlers_config_path]:
    ensure => $directory_ensure,
    require => [Package[$package_name],File[$conf_dir]],
  }

  class { '::diamond::service':
    service_name    => $service_name,
    service_enable  => $service_enable,
    service_manage  => $service_manage,
    service_ensure  => $service_ensure,
    service_restart => $service_restart,
  }

}
