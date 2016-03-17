module Nb
  class People < Service

    def self.find_signup_image(user_email)
      person_email_match(user_email)['person']['profile_image_url_ssl'] if person_email_match(user_email)['person']
    end

    def self.find_self_in_nation
      @token_owner_id = client.call(:people, :me)['person']['id']
    end

    def self.remove_tag(user_email, tag_name)
      user_id = find_nbid_in_nation(user_email)
      client.call(:people,
                  :tag_removal,
                  id: user_id,
                  tag: tag_name)
    end

    def self.add_tag(user_email, tag_name)
      user_id = find_nbid_in_nation(user_email)
      client.call(:people,
                  :tag_person,
                  id: user_id,
                  tagging:
                  {
                    tag: tag_name
                  })
    end

    # Private class methods

    def self.find_nbid_in_nation(user_email)
      person_email_match(user_email)['person']['id'] if person_email_match(user_email)['person']
    end

    def self.person_email_match(user_email)
      @person_email_match ||= client.call(:people, :match, person: { email: user_email })
    end

    private_class_method :find_nbid_in_nation, :match_on_email
  end
end
