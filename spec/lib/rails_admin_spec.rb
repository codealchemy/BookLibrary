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

    context 'Authors' do
      let(:subject) { RailsAdmin::AbstractModel.new(Author) }

      %w(show list edit export).each do |action|
        describe action do
          let(:fields) { subject.config.public_send(action.to_sym).fields }

          it "#{action} the configured fields for the model" do
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

      %w(list edit export).each do |action|
        describe action do
          let(:fields) { subject.config.public_send(action.to_sym).fields }

          it "#{action} the configured fields for the model" do
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              title authors location description
            ))
          end
        end
      end

      describe "show" do
        let(:fields) { subject.config.show.fields }

        it "shows the configured fields for the model" do
          fields.each { |field| expect(field).to be_visible }
          expect(fields.map(&:name)).to match_array(%i(
            title authors location description isbn owner
          ))
        end
      end
    end

    context 'Locations' do
      let(:subject) { RailsAdmin::AbstractModel.new(Location) }

      %w(show list export).each do |action|
        describe action do
          let(:fields) { subject.config.public_send(action.to_sym).fields }

          it "#{action} the configured fields for the model" do
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              name users books_available books_checked_out
            ))
          end
        end
      end

      describe "edit" do
        let(:fields) { subject.config.edit.fields }

        it "shows the configured fields for the model" do
          fields.each { |field| expect(field).to be_visible }
          expect(fields.map(&:name)).to match_array(%i(
            name address1 address2 city state zip country users books
          ))
        end
      end
    end

    context 'Loans' do
      let(:subject) { RailsAdmin::AbstractModel.new(Loan) }

      %w(show list edit export).each do |action|
        describe action do
          let(:fields) { subject.config.public_send(action.to_sym).fields }

          it "#{action} the configured fields for the model" do
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

      %w(list export).each do |action|
        describe action do
          let(:fields) { subject.config.public_send(action.to_sym).fields }

          it "#{action} the configured fields for the model" do
            fields.each { |field| expect(field).to be_visible }
            expect(fields.map(&:name)).to match_array(%i(
              email first_name last_name location
            ))
          end
        end
      end

      describe "show" do
        let(:fields) { subject.config.show.fields }

        it "shows the configured fields for the model" do
          fields.each { |field| expect(field).to be_visible }
          expect(fields.map(&:name)).to match_array(%i(
            email first_name last_name location admin books_borrowed books_owned
          ))
        end
      end

      describe "edit" do
        let(:fields) { subject.config.edit.fields }

        it "shows the configured fields for the model" do
          fields.each { |field| expect(field).to be_visible }
          expect(fields.map(&:name)).to match_array(%i(
            email password first_name last_name location
          ))
        end
      end
    end
  end
end
