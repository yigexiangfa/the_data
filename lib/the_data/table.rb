require 'csv'
require 'the_data/config'
require 'the_data/import'
require 'the_data/export'

class TheData::Table
  include TheData::Import
  include TheData::Export

  attr_reader :table_list_id,
              :collection,
              :columns

  # collection = -> { User.limit(10) }
  # columns = {
  #  name: {
  #    header: 'My name',
  #    field: -> {}
  #  },
  #  email: {
  #    header: 'Email',
  #    field: -> {}
  #  }
  #}

  def initialize(table_list_id = nil)
    @table_list_id = table_list_id
    @collection = nil
    @columns = {}
  end

  def collection_result
    collection.call
  end

  def inflector
    @inflector = TheData.config.inflector
  end

  def config
    raise 'should call in subclass'
  end

  def self.config(*args)
    table_list_id = args.shift
    report = self.new(table_list_id)
    report.config(*args)
  end

  def self.to_table(*args)
    config(*args).to_table
  end

end
