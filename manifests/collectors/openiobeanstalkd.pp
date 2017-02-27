class diamond::collectors::openiobeanstalkd (
  $collector_name = 'OpenioBeanstalkdCollector',
  $enabled        = true,
  $instances      = 'OPENIO:127.0.0.1:6014',
) inherits ::diamond::params {

  include ::diamond

  case $::os['family'] {
    'Debian': { $beanstalkc_package_name = 'python-beanstalkc' }
    'RedHat': { $beanstalkc_package_name = 'beanstalkc' }
    default: { $beanstalkc_package_name = 'python-beanstalkc' }
  }

  #ensure_packages(["${::diamond::package_name}-openio"],{'ensure' => ${::diamond::package_ensure}})
  ensure_packages(["${::diamond::package_name}-openio",$beanstalkc_package_name])

  file {"${::diamond::collectors_config_path}/${collector_name}.conf":
    ensure  => $::diamond::file_ensure,
    content => template('diamond/collectors/openiobeanstalkd.conf.erb'),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
    require => Package["${::diamond::package_name}-openio"],
  }

}
