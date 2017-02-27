class {'diamond':
#  handlers => 'diamond.handler.graphite.GraphiteHandler',
  handlers => 'diamond.handler.graphite.GraphiteHandler,diamond.handler.archive.ArchiveHandler',
  collectors_default => {'interval' => 10},
}
class {'diamond::handlers::graphite':
  host => '127.0.0.1',
}
class {'diamond::handlers::archive': }
diamond::collector {'DiskSpaceCollector,DiskUsageCollector,LoadAverageCollector,MemoryCollector,VMStatCollector,NetworkCollector,SmartCollector':}
class {'diamond::collectors::cpu':
  normalize => true,
}
class {'diamond::collectors::openiosds':
  namespaces => 'OPENIO',
}
class {'diamond::collectors::openioredis':
  instances => "OPENIO:${ipaddress}:6011",
}
class {'diamond::collectors::openiozookeeper':
  instances => "OPENIO:${ipaddress}:6005",
}
class {'diamond::collectors::openiobeanstalkd':
  instances => "OPENIO:${ipaddress}:6014",
}
