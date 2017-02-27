class diamond::params {

  case $::os['family'] {
    'Debian': { $package_name = 'diamond' }
    'RedHat': { $package_name = 'python-diamond' }
    default: { $package_name = 'diamond' }
  }
  $package_ensure = 'present'
  $user = 'diamond'
  $user_ensure = 'present'
  $group = 'diamond'
  $group_ensure = 'present'
  $conf_dir = '/etc/diamond'
  $directory_ensure = 'directory'
  $conf_file = 'diamond.conf'
  $file_ensure = 'present'
  $conf_template = 'diamond/diamond.conf.erb'
  $collectors_config_path = '/etc/diamond/collectors'
  $collectors_path = '/usr/share/diamond/collectors/'
  $handlers_config_path = '/etc/diamond/handlers'
  $handlers_path = '/usr/share/diamond/handlers/'
  $service_name = 'diamond'
  $service_enable = true
  $service_manage = true
  $service_ensure = 'running'
  $service_restart = undef 
  $handlers = undef
  $pid_file = '/run/diamond.pid'
  $collectors_load_delay = undef
  $metric_queue_size = 65536
  $collectors_default = {'interval' => 300}
  $loggers = {'keys' => 'root'}
  $formatters = {'keys' => 'default'}
  $logger_root = {'logger' => 'INFO', 'handlers' => 'rotated_file', 'propagate' => 1}
  $handler_rotated_file = {'class' => 'handlers.TimedRotatingFileHandler', 'level' => 'INFO', 'formatter' => 'default', 'args' => '(\'/var/log/diamond/diamond.log\', \'midnight\', 1, 7)'}
  $formatter_default = {'format' => '[%(asctime)s] [%(threadName)s] %(message)s', 'datefmt' => ''}
  $configs = {}

}
