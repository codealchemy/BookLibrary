require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context '#name' do
    it 'pulls the first and last name of the user' do
      expect(user.name).to eq('Abraham Lincoln')
    end

    it 'pulls the first name of the user if no last name exists' do
      user.last_name = nil

      expect(user.name).to eq('Abraham')
    end

    it 'pulls the last name of the user if no first name exists' do
      user.first_name = nil

      expect(user.name).to eq('Lincoln')
    end

    it 'returns the users email if no first or last name is given' do
      user.assign_attributes(first_name: nil, last_name: nil)

      expect(user.name).to eq(user.email)
    end
  end

  context 'emails' do
    it 'sends a signup email' do
      expect do
        user.send_signup_email
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends an overdue email' do
      expect do
        user.send_overdue_email
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
