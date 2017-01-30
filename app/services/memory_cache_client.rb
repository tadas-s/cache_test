class MemoryCacheClient
  def self.instance
    @client ||= Faraday.new(url: ENV['API_URL']) do |builder|
      builder.use :http_cache,
        store: ActiveSupport::Cache.lookup_store(:memory_store, size: 64.megabytes)
      builder.adapter Faraday.default_adapter
    end
  end
end
