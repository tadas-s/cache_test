class ConsumerController < ApplicationController
  def no_cache
    srand params[:seed].to_i

    client = NoCacheClient.instance

    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"

    render plain: 'ok!'
  end

  def file_cache
    srand params[:seed].to_i

    client = FileCacheClient.instance

    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"

    render plain: 'ok!'
  end

  def memcached_cache
    srand params[:seed].to_i

    client = MemcacheClient.instance

    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"

    render plain: 'ok!'
  end

  def memory_cache
    srand params[:seed].to_i

    client = MemoryCacheClient.instance

    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"

    render plain: 'ok!'
  end

  def redis_cache
    srand params[:seed].to_i

    client = RedisCacheClient.instance

    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"
    client.get "/api/#{rand(1...1_000_000)}"

    render plain: 'ok!'
  end
end
