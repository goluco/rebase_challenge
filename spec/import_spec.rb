# frozen_string_literal: true

require 'spec_helper'
require 'import'

describe 'Import' do
  it 'Deve ser da classe Import' do
    import = Import.new

    expect(import.class).to eq Import
  end
end
