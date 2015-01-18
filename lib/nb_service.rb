class NbService
  require 'nationbuilder'

  CLIENT = NationBuilder::Client.new(ENV['NATION_SLUG'], ENV['NATION_TOKEN'])

  def self.find_nbid_in_nation(user_email)
    match = CLIENT.call(:people, :push, person: { email: user_email })
    match['person'] ? @user_nbid = match['person']['id'] : @user_nbid = nil
  end

  def self.find_signup_image(user_email)
    CLIENT.call(:people, :push, person: { email: user_email })['person']['profile_image_url_ssl']
  end

  def self.find_self_in_nation
    @token_owner_id = CLIENT.call(:people, :me)['person']['id']
  end

  def self.find_contact_type_id(contact_type)
    background do
      index = CLIENT.call(:contact_types, :index, per_page: 100)
      index['results'].each do |result|
        if result['name'] == contact_type
          @type_id = result['id']
        else
          create_contact_type(contact_type)
        end
      end
    end
  end

  def self.create_contact_type(name)
    background do
      type = CLIENT.call(:contact_types,
                         :create,
                         contact_type: {
                           name: name
                         })
      @type_id = type['contact_type']['id'] if type['contact_types']
    end
  end

  def self.log_contact(loan, contact_type)
    find_nbid_in_nation(loan.user.email)
    find_contact_type_id(contact_type)
    find_self_in_nation
    background do
      CLIENT.call(:contacts, :create, person_id: @user_nbid, contact:
      {
        sender_id: @token_owner_id,
        broadcaster_id: ENV['NATION_BROADCASTER_ID'],
        method: 'other',
        type_id: @type_id,
        note: "#{contact_type} - Title '#{loan.book.title}' by #{loan.book.author_name}"
      })
    end
  end

  def self.remove_tag(user_email, tag_name)
    find_nbid_in_nation(user_email)
    background do
      CLIENT.call(:people,
                  :tag_removal,
                  id: @user_nbid,
                  tag: tag_name)
    end
  end

  def self.add_tag(user_email, tag_name)
    find_nbid_in_nation(user_email)
    background do 
      CLIENT.call(:people,
                  :tag_person,
                  id: @user_nbid,
                  tagging:
                  {
                    tag: tag_name
                  })
    end
  end

  def self.background(&block)
    Thread.new do
      yield
      ActiveRecord::Base.connection.close
    end
  end
end
