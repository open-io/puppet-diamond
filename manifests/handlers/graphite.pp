class diamond::handlers::graphite (
  $handler_name = 'GraphiteHandler',
  $enabled      = true,
  $host         = 'graphite',
  $port         = 2003,
  $timeout      = 10,
  $batch        = 1000,
) inherits ::diamond::params {

  include ::diamond

  file {"${::diamond::handlers_config_path}/${handler_name}.conf":
    ensure  => $::diamond::file_ensure,
    content => template("diamond/handlers/graphite.conf.erb"),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
  }

}
