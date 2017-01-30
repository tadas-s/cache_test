class RedisCacheClient
  def self.instance
    @client ||= Faraday.new(url: ENV['API_URL']) do |builder|
      builder.use :http_cache,
        store: ActiveSupport::Cache.lookup_store(
          :redis_store,
          ENV['REDISCLOUD_URL'],
          :pool_size => [ENV['MAX_THREADS'].to_i, 5].max
        )
      builder.adapter Faraday.default_adapter
    end
  end
end
