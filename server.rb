# frozen_string_literal: true

require 'sidekiq'
require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative './lib/import'
require_relative './lib/query'
require_relative './sidekiq/my-worker'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://myredis:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://myredis:6379/0' }
end

post '/import' do
  MyWorker.perform_async(params['path'])
end

get '/tests' do
  query = Query.new('postgres', 'medical_records')
  query.results
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
