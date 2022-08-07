# frozen_string_literal: true

require 'pg'

class Query
  attr_reader :connection

  def initialize(provided_host, provided_dbname)
    @connection = PG.connect(host: provided_host, dbname: provided_dbname, user: 'user', password: 'password')
  end

  def results
    result = @connection.exec('SELECT * FROM exams')
    result.map { |tuple| tuple }.to_json
  rescue PG::UndefinedTable
    false
  end

  def search(provided_token)
    column = 'token resultado exame'
    result = @connection.exec("SELECT * FROM exams WHERE '#{column}' = '#{provided_token}'")
    result.map { |tuple| tuple }
  end
end
