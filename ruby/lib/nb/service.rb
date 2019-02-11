require 'nationbuilder'

module Nb
  class Service

    def self.client
      @client ||= NationBuilder::Client.new(ENV['NATION_SLUG'], ENV['NATION_TOKEN'])
    end

    private_class_method :client
  end
end
