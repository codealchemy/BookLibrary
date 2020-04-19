require 'rails_helper'

RSpec.describe UserNotifier, type: :mailer do
  describe 'account email' do
    let(:user) { create(:user, first_name: 'Locas', email: 'lucas@email.com') }
    let(:signup_mail) { UserNotifier.send_signup_email(user) }

    it 'renders the subject' do
      expect(signup_mail.subject).to eql('Your account is ready to go!')
    end

    it 'renders the receiver email' do
      expect(signup_mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(signup_mail.from).to eql(['from@example.com'])
    end
  end

  describe 'overdue email' do
    let(:user) { create(:user, first_name: 'Locas', email: 'lucas@email.com') }
    let(:overdue_mail) { UserNotifier.send_overdue_email(user) }

    it 'renders the subject' do
      expect(overdue_mail.subject).to eql('You have an overdue book')
    end
    
    it 'renders the receiver email' do
      expect(overdue_mail.to).to eql([user.email])
    end
    
    it 'renders the sender email' do
      expect(overdue_mail.from).to eql(['from@example.com'])
    end
  end
end
