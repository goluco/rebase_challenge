# frozen_string_literal: true

require 'sidekiq'
require './lib/import'
require 'csv'

class Worker 
  include Sidekiq::Worker

  def perform(csv_path)
    rows = CSV.read(csv_path.to_s, col_sep: ';')
    rows.shift
    
    import = Import.new('postgres', 'medical_records')
    import.drop_table
    import.create_table

    rows.each do |row|
      import.insert_data(row)
    end
  end
end