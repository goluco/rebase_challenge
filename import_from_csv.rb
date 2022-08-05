# frozen_string_literal: true

require 'sidekiq'
require './sidekiq/worker'
require_relative './lib/import'
require 'csv'

Sidekiq.configure_client do |config|
  config.redis = { url = 'redis//redis:6379/0' }
end

Worker.perform_async('./data_csv')