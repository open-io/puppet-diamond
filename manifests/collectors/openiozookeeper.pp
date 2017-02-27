class diamond::collectors::openiozookeeper (
  $collector_name = 'OpenioZookeeperCollector',
  $enabled        = true,
  $instances      = 'OPENIO:127.0.0.1:6005',
) inherits ::diamond::params {

  include ::diamond

  case $::os['family'] {
    'Debian': { $zookeeper_package_name = 'python-zookeeper' }
    'RedHat': { $zookeeper_package_name = 'python-ZooKeeper' }
    default: { $zookeeper_package_name = 'python-zookeeper' }
  }

  #ensure_packages(["${::diamond::package_name}-openio"],{'ensure' => ${::diamond::package_ensure}})
  ensure_packages(["${::diamond::package_name}-openio",$zookeeper_package_name])

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
