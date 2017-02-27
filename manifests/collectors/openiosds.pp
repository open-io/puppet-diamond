class diamond::collectors::openiosds (
  $collector_name = 'OpenIOSDSCollector',
  $enabled        = true,
  $namespaces     = 'OPENIO',
  $fs_types       = 'xfs, ext4',
) inherits ::diamond::params {

  include ::diamond

  case $::os['family'] {
    'Debian': { $openiosds_package_name = 'openio-sds' }
    'RedHat': { $openiosds_package_name = 'openio-sds-common' }
    default: { $openiosds_package_name = 'openio-sds' }
  }

  #ensure_packages(["${::diamond::package_name}-openio"],{'ensure' => ${::diamond::package_ensure}})
  ensure_packages(["${::diamond::package_name}-openio",$openiosds_package_name])

  file {"${::diamond::collectors_config_path}/${collector_name}.conf":
    ensure  => $::diamond::file_ensure,
    content => template('diamond/collectors/openiosds.conf.erb'),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
    require => Package["${::diamond::package_name}-openio"],
  }

}
