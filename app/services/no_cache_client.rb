# Client with no caching enabled
class NoCacheClient
  def self.instance
    @client ||= Faraday.new(url: ENV['API_URL']) do |builder|
      builder.adapter Faraday.default_adapter
    end
  end
end