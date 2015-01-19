module Nb
  class People < Service

    def self.find_nbid_in_nation(user_email)
      match = CLIENT.call(:people, :push, person: { email: user_email })
      match['person']['id']
    end

    def self.find_signup_image(user_email)
      match = CLIENT.call(:people,
                  :push,
                  person:
                  {
                    email: user_email
                  })
      match['person']['profile_image_url_ssl'] if match['person']
    end

    def self.find_self_in_nation
      @token_owner_id = CLIENT.call(:people, :me)['person']['id']
    end

    def self.remove_tag(user_email, tag_name)
      user_id = find_nbid_in_nation(user_email)
      background do
        CLIENT.call(:people,
                    :tag_removal,
                    id: user_id,
                    tag: tag_name)
      end
    end

    def self.add_tag(user_email, tag_name)
      user_id = find_nbid_in_nation(user_email)
      background do
        CLIENT.call(:people,
                    :tag_person,
                    id: user_id,
                    tagging:
                    {
                      tag: tag_name
                    })
      end
    end
  end
end