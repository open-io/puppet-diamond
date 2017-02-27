class {'diamond':
#  handlers => 'diamond.handler.graphite.GraphiteHandler',
  handlers => 'diamond.handler.graphite.GraphiteHandler,diamond.handler.archive.ArchiveHandler',
  collectors_default => {'interval' => 10}
}
class {'diamond::handlers::graphite': }
class {'diamond::handlers::archive': }
diamond::collector {'CPUCollector,DiskSpaceCollector,DiskUsageCollector,LoadAverageCollector,MemoryCollector,VMStatCollector,NetworkCollector':}
