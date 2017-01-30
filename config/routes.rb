# frozen_string_literal: true
Rails.application.routes.draw do
  get 'api/:seed', controller: :api, action: :api

  get 'consumer/no_cache/:seed', controller: :consumer, action: :no_cache
  get 'consumer/file_cache/:seed', controller: :consumer, action: :file_cache
  get 'consumer/memcached_cache/:seed', controller: :consumer, action: :memcached_cache
  get 'consumer/memory_cache/:seed', controller: :consumer, action: :memory_cache
  get 'consumer/redis_cache/:seed', controller: :consumer, action: :redis_cache
end
