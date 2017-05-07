require 'rails_helper'

RSpec.describe Location, type: :model do
  context "validations" do
    it "is invalid without a name" do
      expect(build(:location, name: nil)).to be_invalid
    end
  end
end
