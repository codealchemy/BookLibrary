class NbService
  require 'nationbuilder'

  CLIENT = NationBuilder::Client.new(ENV['NATION_SLUG'], ENV['NATION_TOKEN'])

  def self.find_nbid_in_nation(user)
    match = CLIENT.call(:people, :push, person: { email: user.email })
    match['person'] ? @user_nbid = match['person']['id'] : @user_nbid = nil
  end

  def self.find_checkout_id(in_or_out)
    if in_or_out == 'in'
      @type_id = ENV['NATION_CHECKIN_ID']
    elsif in_or_out == 'out'
      @type_id = ENV['NATION_CHECKOUT_ID']
    end
  end

  def self.borrow_contact(loan, in_or_out)
    find_nbid_in_nation(loan.user)
    find_checkout_id(in_or_out)

    CLIENT.call(:contacts, :create, person_id: @user_nbid, contact:
    {
      sender_id: ENV['NATION_SENDER_ID'],
      broadcaster_id: ENV['NATION_BROADCASTER_ID'],
      method: 'other',
      type_id: @type_id,
      note: "Checked #{in_or_out} book '#{loan.book.title}' at #{loan.checked_in_at}"
    })
  end

  def self.account_tag(user_email, status)
    CLIENT.call(:people, :push, person:
    {
      email: user_email,
      tags: "Library account #{status}"
    })
  end
end
