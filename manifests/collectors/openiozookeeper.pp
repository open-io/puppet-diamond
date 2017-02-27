class diamond::collectors::openiozookeeper (
  $collector_name = 'OpenioZookeeperCollector',
  $enabled        = true,
  $instances      = 'OPENIO:127.0.0.1:6005',
) inherits ::diamond::params {

  include ::diamond

  #ensure_packages(["${::diamond::package_name}-openio"],{'ensure' => ${::diamond::package_ensure}})
  ensure_packages(["${::diamond::package_name}-openio"])

  file {"${::diamond::collectors_config_path}/${collector_name}.conf":
    ensure  => $::diamond::file_ensure,
    content => template('diamond/collectors/openiozookeeper.conf.erb'),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
    require => Package["${::diamond::package_name}-openio"],
  }

}
