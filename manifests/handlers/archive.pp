class diamond::handlers::archive (
  $handler_name = 'ArchiveHandler',
  $enabled      = true,
  $log_file     = '/var/log/diamond/archive.log',
  $days         = 1,
) inherits ::diamond::params {

  include ::diamond

  file {"${::diamond::handlers_config_path}/${handler_name}.conf":
    ensure  => $::diamond::file_ensure,
    content => template("diamond/handlers/archive.conf.erb"),
    owner   => $::diamond::user,
    group   => $::diamond::group,
    mode    => '0644',
    notify  => Class['Diamond::Service'],
  }

}
