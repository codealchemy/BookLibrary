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

  context 'contact types' do
    before do
      allow_any_instance_of(NationBuilder::Client).to receive(:call)
        .and_return({ 'results' => [{ 'name' => 'Book check-out', 'id' => 1 }] })
    end

    describe '#type_id' do
      it 'returns the type_id for the given contact type' do
        expect(described_class.send(:type_id, 'Book check-out')).to eq(1)
      end
    end

    describe '#create_contact_type' do
      it 'constructs a request to create the contact type in the nation' do
        expect_any_instance_of(NationBuilder::Client).to receive(:call).with(
          :contact_types, :create, contact_type: { name: 'Book anomaly' }
        )
        described_class.send(:create_contact_type, 'Book anomaly')
      end
    end
  end
end
