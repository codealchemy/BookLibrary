class NbService
  require 'nationbuilder'

  CLIENT = NationBuilder::Client.new(ENV['NATION_SLUG'], ENV['NATION_TOKEN'])

  def self.find_nbid_in_nation(user_email)
    match = CLIENT.call(:people, :push, person: { email: user_email })
    match['person'] ? @user_nbid = match['person']['id'] : @user_nbid = nil
  end

  def self.find_checkout_id(in_or_out)
    if in_or_out =~ /in/
      @type_id = ENV['NATION_CHECKIN_ID']
    else
      @type_id = ENV['NATION_CHECKOUT_ID']
    end
  end

  def self.borrow_contact(loan, in_or_out)
    find_nbid_in_nation(loan.user)
    find_checkout_id(in_or_out)
    background do
      CLIENT.call(:contacts, :create, person_id: @user_nbid, contact:
      {
        sender_id: ENV['NATION_SENDER_ID'],
        broadcaster_id: ENV['NATION_BROADCASTER_ID'],
        method: 'other',
        type_id: @type_id,
        note: "Checked #{in_or_out} book '#{loan.book.title}'"
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
