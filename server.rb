require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative './lib/import'
require_relative './lib/query'

get '/tests' do
  rows = CSV.read('./data.csv', col_sep: ';')
  rows.shift
  import = Import.new('postgres', 'medical_records')

  import.drop_table
  import.create_table

  rows.each do |row|
    import.insert_data(row)
  end

  query = Query.new('postgres', 'medical_records')
  query.results
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
