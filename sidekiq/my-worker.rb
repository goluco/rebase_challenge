# frozen_string_literal: true

require 'sidekiq'
require_relative '../lib/import'
require 'csv'

class MyWorker 
  include Sidekiq::Worker

  def perform(csv_path)
    rows = CSV.read(csv_path, col_sep: ';')
    rows.shift
    import = Import.new('postgres', 'medical_records')
    import.drop_table
    import.create_table

    rows.each do |row|
      import.insert_data(row)
    end
  end
end
