require 'rails_helper'

RSpec.describe RailsAdmin do

  describe 'RailsAdmin authentication config' do

    it 'authenticates with warden to the user scope' do
      expect(RailsAdmin::Config.authenticate_with.source).to include(
        'warden.authenticate! scope: :user'
      )
    end

    it 'sets the current_user_method to :current_user' do
      example_user     = create(:user)
      example_receiver = OpenStruct.new(current_user: example_user)

      expect(RailsAdmin::Config.current_user_method.call(example_receiver)).to eq(example_user)
    end
  end

  describe 'Configured actions' do
    configured_actions = %w(show list edit export)

    context 'Authors' do
      let(:subject) { RailsAdmin::AbstractModel.new(Author) }

      configured_actions.each do |action|
        describe action do
          it "#{action} the configured fields for the model" do
            fields = subject.config.show.fields
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              first_name last_name books
            ))
          end
        end
      end
    end

    context 'Books' do
      let(:subject) { RailsAdmin::AbstractModel.new(Book) }

      configured_actions.each do |action|
        describe action do
          it "#{action} the configured fields for the model" do
            fields = subject.config.show.fields
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              title authors isbn description owner
            ))
          end
        end
      end
    end

    context 'Locations' do
      let(:subject) { RailsAdmin::AbstractModel.new(Location) }

      configured_actions.each do |action|
        describe action do
          it "#{action} the configured fields for the model" do
            fields = subject.config.show.fields
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              name address1 address2 city state zip country users books
            ))
          end
        end
      end
    end

    context 'Loans' do
      let(:subject) { RailsAdmin::AbstractModel.new(Loan) }

      configured_actions.each do |action|
        describe action do
          it "#{action} the configured fields for the model" do
            fields = subject.config.show.fields
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              user book checked_out_at checked_in_at due_date
            ))
          end
        end
      end
    end

    context 'Users' do
      let(:subject) { RailsAdmin::AbstractModel.new(User) }

      configured_actions.each do |action|
        describe action do
          it "#{action} the configured fields for the model" do
            fields = subject.config.public_send(action.to_sym).fields
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              email admin password first_name last_name location books_owned books_borrowed
            ))
          end
        end
      end
    end
  end
end
