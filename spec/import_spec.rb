# frozen_string_literal: true

require 'spec_helper'
require 'import'

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
