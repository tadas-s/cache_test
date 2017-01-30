# Client with memcache/dalli store
class FileCacheClient
  def self.instance
    @client ||= Faraday.new(url: ENV['API_URL']) do |builder|
      builder.use :http_cache,
                  store: ActiveSupport::Cache.lookup_store(:file_store, '/tmp/api')
      builder.adapter Faraday.default_adapter
    end
  end
end