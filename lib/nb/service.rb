module Nb
  require 'nationbuilder'
  
  class Service

    private
    
    CLIENT = NationBuilder::Client.new(ENV['NATION_SLUG'], ENV['NATION_TOKEN'])

    def self.background(&block)
      Thread.new do
        yield
        ActiveRecord::Base.connection.close
      end
    end
  end
end
