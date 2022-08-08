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
    result = @connection.exec(%Q{ SELECT * FROM exams WHERE "token resultado exame" = '#{provided_token}' })
    return false if result.cmd_tuples.zero?

    patient_columns = ['token resultado exame', 'data exame', 'cpf',
                       'nome paciente', 'email paciente', 'data nascimento paciente']
    physician_columns = ['crm médico', 'crm médico estado', 'nome médico']
    exam_columns = ['tipo exame', 'limites tipo exame', 'resultado tipo exame']
    first_row = result.first
    data = first_row.select { |key, _value| patient_columns.include?(key) }
    data['médico'] = first_row.select { |key, _value| physician_columns.include?(key) }
    data['exames'] = result.map { |row| row.select { |key, _value| exam_columns.include?(key) } }
    data.to_json
  end
end
