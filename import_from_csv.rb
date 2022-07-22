# frozen_string_literal: true

require_relative './lib/import'
require 'csv'

rows = CSV.read('./data.csv', col_sep: ';')
rows.shift
import = Import.new('postgres', 'medical_records')

import.drop_table
import.create_table

rows.each do |row|
  import.insert_data(row)
end
