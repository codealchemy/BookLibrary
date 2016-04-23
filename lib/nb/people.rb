module Nb
  class People < Service

    def self.remove_tag(options)
      user_id = find_nbid_in_nation(options[:email])
      client.call(:people, :tag_removal, id: user_id, tag: options[:tag_to_remove])
    end

    def self.add_tag(options)
      user_id = find_nbid_in_nation(options[:email])
      add_and_tag_person(options) unless user_id
      client.call(:people, :tag_person, id: user_id, tagging: { tag: options[:tag_to_add] })
    end

    # Private class methods

    def self.add_and_tag_person(options)
      client.call(:people, :add, person: { email: options[:email], tags: options[:tag_to_add] })
    end

    def self.find_nbid_in_nation(email)
      match = client.call(:people, :match, email: email)
      @matched_id = match['person']['id'] if match
    rescue NationBuilder::ClientError
      # Person doesn't exist in the nation
    end

    private_class_method :find_nbid_in_nation, :add_and_tag_person
  end
end
