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
    result = Faraday.get('http://localhost:3000/tests/IQCZ17')

    expect(result.status).to eq 200
    expect(result.body).to eq(
      {
        "result_token":"IQCZ17",
        "result_date":"2021-08-05",
        "cpf":"048.973.170-88",
        "name":"Emilly Batista Neto",
        "email":"gerald.crona@ebert-quigley.com",
        "birthday":"2001-03-11",
        "doctor": {
                    "crm":"B000BJ20J4",
                    "crm_state":"PI",
                    "name":"Maria Luiza Pires"
   },
        "tests":[
      {
         "type":"hemácias",
         "limits":"45-52",
         "result":"97"
      },
      {
         "type":"leucócitos",
         "limits":"9-61",
         "result":"89"
      },
      {
         "test_type":"plaquetas",
         "test_limits":"11-93",
         "result":"97"
      },
      {
         "test_type":"hdl",
         "test_limits":"19-75",
         "result":"0"
      },
      {
         "test_type":"ldl",
         "test_limits":"45-54",
         "result":"80"
      },
      {
         "test_type":"vldl",
         "test_limits":"48-72",
         "result":"82"
      },
      {
         "test_type":"glicemia",
         "test_limits":"25-83",
         "result":"98"
      },
      {
         "test_type":"tgo",
         "test_limits":"50-84",
         "result":"87"
      },
      {
         "test_type":"tgp",
         "test_limits":"38-63",
         "result":"9"
      },
      {
         "test_type":"eletrólitos",
         "test_limits":"2-68",
         "result":"85"
      },
      {
         "test_type":"tsh",
         "test_limits":"25-80",
         "result":"65"
      },
      {
         "test_type":"t4-livre",
         "test_limits":"34-60",
         "result":"94"
      },
      {
         "test_type":"ácido úrico",
         "test_limits":"15-61",
         "result":"2"
      }
   ]
}
    )
  end
end
