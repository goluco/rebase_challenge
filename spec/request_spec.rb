# frozen_string_literal: true

require 'spec_helper'
require 'import'
require 'csv'
require 'faraday'

describe '/post import' do
  it 'envia request e retorna 200' do
    params = { path: '/app/test_data.csv' }

    result = Faraday.post('http://localhost:3000/import', params)

    expect(result.status).to eq 200
  end
end

describe '/get tests/:token' do
  it 'acessa um pagina token e recebe json correspondente' do
    result = Faraday.get('http://localhost:3000/tests/')
  end
end
