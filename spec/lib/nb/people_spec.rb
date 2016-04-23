require 'rails_helper'

RSpec.describe Nb::People do

  let(:person_params) { { email: 'roger@example.com' } }

  describe '#add_tag' do
    it 'constructs a request to add a tag from person' do
      params_with_tag = person_params.merge(tag_to_add: 'check this out')
      allow(Nb::People).to receive(:find_nbid_in_nation).with(person_params[:email]).and_return(1)

      expect_any_instance_of(NationBuilder::Client).to receive(:call)
        .with(:people, :tag_person, id: 1, tagging: { tag: 'check this out' })
      described_class.add_tag(params_with_tag)
    end
  end

  describe '#remove_tag' do
    it 'constructs a request to remove a tag from person' do
      params_with_tag = person_params.merge(tag_to_remove: 'get rid of this')
      allow(Nb::People).to receive(:find_nbid_in_nation).with(person_params[:email]).and_return(1)

      expect_any_instance_of(NationBuilder::Client).to receive(:call)
        .with(:people, :tag_removal, id: 1, tag: 'get rid of this')
      described_class.remove_tag(params_with_tag)
    end
  end

  describe '#find_nbid_in_nation' do
    it 'constructs a request to match the person by email' do
      allow_any_instance_of(NationBuilder::Client).to receive(:call)
        .and_return('person' => { 'id' => 1 })

      expect_any_instance_of(NationBuilder::Client).to receive(:call)
        .with(:people, :match, email: 'test@example.com')

      described_class.send(:find_nbid_in_nation, 'test@example.com')
    end

    it 'returns nil if no match is found' do
      allow_any_instance_of(NationBuilder::Client).to receive(:call)
        .and_raise(NationBuilder::ClientError)

      allow_any_instance_of(NationBuilder::Client).to receive(:call)
        .with(:people, :match, email: 'test@example.com')

      response = described_class.send(:find_nbid_in_nation, 'test@example.com')
      expect(response).to be_nil
    end
  end

  # Private class methods

  describe '#add_and_tag_person' do
    it 'constructs a request to add and tag a person' do
      params_with_tag = person_params.merge(tag_to_add: 'check this out')
      expected_params = person_params.merge(tags: 'check this out')

      expect_any_instance_of(NationBuilder::Client).to receive(:call)
        .with(:people, :add, person: expected_params)
      described_class.send(:add_and_tag_person, params_with_tag)
    end

    it 'gets a response in the form of a person hash' do
      params_with_tag = person_params.merge(tag_to_add: 'check this out')

      allow_any_instance_of(NationBuilder::Client).to receive(:call)
        .and_return('person' => { 'id' => 1 })
      described_class.send(:add_and_tag_person, params_with_tag)
    end
  end
end
