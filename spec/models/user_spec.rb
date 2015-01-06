require 'rails_helper'

RSpec.describe User, :type => :model do
  context "#author names" do
    it "pulls the first and last name of the user"
    it "pulls the first name of the user if no last name exists"
    it "pulls the last name of the user if no first name exists"
    it "returns a message for no name for the user" 
  end

  context "#emails" do
    let(:user) { User.create(email: 'alchemitt@example.com', password: 'rogerrabbit') }

    it "sends a signup email" do
      expect { user.send_signup_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "sends an overdue email" do
      expect { user.send_overdue_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
