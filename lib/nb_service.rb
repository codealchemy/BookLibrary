class NbService
  require 'nationbuilder'

  CLIENT = NationBuilder::Client.new(ENV['NATION_SLUG'], ENV['NATION_TOKEN'])

  def self.find_nbid_in_nation(user)
    match = CLIENT.call(:people, :push, person: { email: user.email })
    match['person'] ? @user_nbid = match['person']['id'] : @user_nbid = nil
  end

  def self.check_out_contact(loan)
    find_nbid_in_nation(loan.user)
    CLIENT.call(:contacts, :create, person_id: @user_nbid, contact:
    {
      sender_id: ENV['NATION_SENDER_ID'],
      broadcaster_id: ENV['NATION_BROADCASTER_ID'],
      method: 'other',
      type_id: ENV['NATION_CHECKOUT_ID'],
      note: "Checked out book '#{loan.book.title}' at #{loan.checked_out_at}"
    })
  end

  def self.check_in_contact(loan)
    find_nbid_in_nation(loan.user)
    CLIENT.call(:contacts, :create, person_id: @user_nbid, contact:
    {
      sender_id: ENV['NATION_SENDER_ID'],
      broadcaster_id: ENV['NATION_BROADCASTER_ID'],
      method: 'other',
      type_id: ENV['NATION_CHECKIN_ID'],
      note: "Checked in book '#{loan.book.title}' at #{loan.checked_in_at}"
    })
  end

  def self.new_account(user_email)
    CLIENT.call(:people, :push, person:
    {
      email: user_email,
      tags: 'Active library account'
    })
  end

  def self.delete_account(user_email)
    CLIENT.call(:people, :push, person:
    {
      email: user_email,
      tags: 'Library account deleted'
    })
  end
end
