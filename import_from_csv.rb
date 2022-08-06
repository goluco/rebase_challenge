# frozen_string_literal: true

require 'sidekiq'
require_relative './sidekiq/my-worker'
require_relative './lib/import'
require 'csv'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://myredis:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://myredis:6379/0' }
end

path = './data.csv'
MyWorker.perform_async(path)
