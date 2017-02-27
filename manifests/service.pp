class diamond::service (
  $service_name   = $::diamond::params::service_name,
  $service_enable = true,
  $service_ensure = 'running',
  $service_manage = true,
  $service_restart = undef
) {

 # The base class must be included first because parameter defaults depend on it
  if ! defined(Class['diamond::params']) {
    fail('You must include the diamond::params class before using any diamond defined resources')
  }
  validate_bool($service_enable)
  validate_bool($service_manage)

  case $service_ensure {
    true, false, 'running', 'stopped': {
      $_service_ensure = $service_ensure
    }
    default: {
      $_service_ensure = undef
    }
  }

  $service_hasrestart = $service_restart == undef

  if $service_manage {
    service { $service_name:
      ensure     => $_service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      restart    => $service_restart,
      hasrestart => $service_hasrestart,
    }
  }

}
