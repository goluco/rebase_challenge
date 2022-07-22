# frozen_string_literal: true

require 'spec_helper'
require 'import'
require 'csv'

describe '#new' do
  it 'deve ser da classe Import' do
    import = Import.new('test', 'testdb')

    expect(import.class).to eq Import
  end
end

describe '#create_table' do
  it 'deve criar uma tabela na base de dados' do
    import = Import.new('test', 'testdb')

    import.create_table
    result = import.connection.exec(%q{
      SELECT EXISTS ( SELECT FROM information_schema.tables WHERE table_schema =
      'public' AND table_name = 'exams' )
    })

    expect(result.values).to include(['t'])
  end
end

describe '#drop_table' do
  it 'deve deletar tabela caso ela exista' do
    import = Import.new('test', 'testdb')

    import.drop_table
    result = import.connection.exec(%q{
      SELECT EXISTS ( SELECT FROM information_schema.tables WHERE table_schema =
      'public' AND table_name = 'exams' )
    })

    expect(result.values).to include(['f'])
  end
end

describe '#insert_data' do
  it 'deve inserir os dados csv na tabela exams do banco de dados' do
    import = Import.new('test', 'testdb')
    import.create_table
    rows = CSV.read('./test_data.csv', col_sep: ';')
    rows.shift

    rows.each do |row|
      import.insert_data(row)
    end

    result = import.connection.exec('SELECT * FROM exams')
    expect(result.values).to include(rows[0])
    expect(result.values).to include(rows[1])
    expect(result.values).to include(rows[2])
    expect(result.values).to include(rows[3])
    expect(result.values).to include(rows[4])
    expect(result.values).to include(rows[5])
    expect(result.values).to include(rows[6])
    expect(result.values).to include(rows[7])
    expect(result.values).to include(rows[8])
  end
end
