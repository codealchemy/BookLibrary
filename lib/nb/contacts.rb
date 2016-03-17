module Nb
  class Contacts < Service

    def self.find_contact_type_id(contact_type)
      index = client.call(:contact_types, :index, per_page: 100)
      index['results'].each do |result|
        if result['name'] == contact_type
          @type_id = result['id']
        else
          create_contact_type(contact_type)
        end
      end
    end

    def self.create_contact_type(name)
      type = client.call(:contact_types,
                         :create,
                         contact_type: {
                           name: name
                         })
      @type_id = type['contact_type']['id'] if type['contact_types']
    end

    def self.log_contact(loan, contact_type)
      signup_id = Nb::People.find_nbid_in_nation(loan.user.email)
      token_owner_id = Nb::People.find_self_in_nation
      find_contact_type_id(contact_type)
      client.call(:contacts, :create, person_id: signup_id, contact:
      {
        sender_id: token_owner_id,
        broadcaster_id: ENV['NATION_BROADCASTER_ID'],
        method: 'other',
        type_id: @type_id,
        note: "#{contact_type} - Title '#{loan.book.title}' by #{loan.book.author_name}"
      })
    end
  end
end
