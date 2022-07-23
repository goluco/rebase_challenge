require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative './lib/import'
require_relative './lib/query'

get '/tests' do
  query = Query.new('postgres', 'medical_records')
  query.results
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
