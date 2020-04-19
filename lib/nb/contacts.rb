module Nb
  class Contacts < Service

    def self.log_contact(loan, contact_type)
      signup_id = Nb::People.find_nbid_in_nation(loan.user.email)
      client.call(:contacts, :create, person_id: signup_id,
                                      contact: {
                                        sender_id: signup_id,
                                        broadcaster_id: ENV['NATION_BROADCASTER_ID'],
                                        method: 'other',
                                        type_id: type_id(contact_type),
                                        note: "#{contact_type} - Title '#{loan.book.title}'"
                                      })
    end

    # Private class methods

    def self.type_id(contact_type)
      index = client.call(:contact_types, :index, per_page: 100)
      result = index['results'].bsearch { |r| r['name'] == contact_type }
      result ? result['id'] : create_contact_type(contact_type)
    end

    def self.create_contact_type(name)
      type = client.call(:contact_types, :create, contact_type: { name: name })
      type['contact_type']['id'] if type['contact_type']
    end

    private_class_method :create_contact_type, :type_id
  end
end
