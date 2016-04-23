require 'rails_helper'

RSpec.describe Nb::Contacts do
  describe '#log_contact' do

    let(:loan) { build(:loan) }
    let(:expected_params) do
      {
        person_id: 1,
        contact: {
          sender_id: 1,
          broadcaster_id: '1',
          method: 'other',
          type_id: 1,
          note: "Book check-out - Title '#{loan.book.title}' by #{loan.book.author_name}"
        }
      }
    end

    it 'constructs a request to log a contact from a person' do
      allow(Nb::Contacts).to receive(:type_id).and_return(1)
      allow(Nb::People).to receive(:find_nbid_in_nation).with(loan.user.email).and_return(1)

      expect_any_instance_of(NationBuilder::Client).to receive(:call)
        .with(:contacts, :create, expected_params)
      described_class.log_contact(loan, 'Book check-out')
    end
  end
end
