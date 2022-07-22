# frozen_string_literal: true

require 'spec_helper'
require 'import'
require 'csv'
require 'query'

describe '#results' do
  it 'deve retornar os dados da tabela exams' do
    import = Import.new('test', 'testdb')
    import.drop_table
    import.create_table
    rows = CSV.read('./test_data.csv', col_sep: ';')
    rows.shift
    rows.each do |row|
      import.insert_data(row)
    end

    query = Query.new('test', 'testdb')
    result = query.results

    expect(result).to include('048.973.170-88')
    expect(result).to include('Emilly Batista Neto')
    expect(result).to include('gerald.crona@ebert-quigley.com')
    expect(result).to include('2001-03-11')
    expect(result).to include('165 Rua Rafaela')
    expect(result).to include('Ituverava')
    expect(result).to include('Alagoas')
    expect(result).to include('B000BJ20J4')
    expect(result).to include('PI')
    expect(result).to include('Maria Luiza Pires')
    expect(result).to include('denna@wisozk.biz')
    expect(result).to include('IQCZ17')
    expect(result).to include('2021-08-05')
    expect(result).to include('hemácias')
    expect(result).to include('45-52')
    expect(result).to include('97')
  end
end
