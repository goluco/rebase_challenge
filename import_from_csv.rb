# frozen_string_literal: true

require_relative './lib/import'

rows = CSV.read('./data_.csv', col_sep: ';')
import = Import.new

import.drop_table
import.create_table

rows.each do |row|
  import.insert_data(row)
end
