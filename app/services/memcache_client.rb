# Client with file cache store
class MemcacheClient
  def self.instance
    @client ||= Faraday.new(url: ENV['API_URL']) do |builder|
      memcache_servers = ENV['MEMCACHEDCLOUD_SERVERS'].split(',')
      memcache_configuration = { :username => ENV['MEMCACHEDCLOUD_USERNAME'],
                                 :password => ENV['MEMCACHEDCLOUD_PASSWORD'],
                                 :failover => true,
                                 :socket_timeout => 1.5,
                                 :socket_failure_delay => 0.2,
                                 :value_max_bytes => 10485760,
                                 :pool_size => [ENV['MAX_THREADS'].to_i, 5].max }

      builder.use :http_cache,
                  store: ActiveSupport::Cache.lookup_store(:dalli_store, memcache_servers, memcache_configuration)
      builder.adapter Faraday.default_adapter
    end
  end
end