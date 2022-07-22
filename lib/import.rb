# frozen_string_literal: true
require 'pg'

class Import
  attr_reader :connection

  def initialize(provided_host, provided_dbname)
    @connection = PG.connect(host: provided_host, dbname: provided_dbname, user: 'user', password: 'password')
  end

  def create_table
    @connection.exec(%q{
        CREATE TABLE IF NOT EXISTS exams (
          "cpf" VARCHAR(14),
          "nome paciente" VARCHAR(100),
          "email paciente" VARCHAR(100),
          "data nascimento paciente" DATE,
          "endereço/rua paciente" VARCHAR(100),
          "cidade paciente" VARCHAR(50),
          "estado patiente" VARCHAR(50),
          "crm médico" VARCHAR(10),
          "crm médico estado" VARCHAR(50),
          "nome médico" VARCHAR(100),
          "email médico" VARCHAR(100),
          "token resultado exame" VARCHAR(10),
          "data exame" DATE,
          "tipo exame" VARCHAR(50),
          "limites tipo exame" VARCHAR(10),
          "resultado tipo exame" INTEGER
        )
    })
  end

  def drop_table
    @connection.exec('DROP TABLE IF EXISTS exams')
  end
end
