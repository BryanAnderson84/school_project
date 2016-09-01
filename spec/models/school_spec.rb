require 'rails_helper'

RSpec.describe School, type: :model do
  describe "validations" do
      it { should validate_presence_of(:name, :type) }
    end

  describe "#school_type" do
    it "returns public of true" do
        item = Item.create(name: 'school', type: true)
        expect(school.school_type).to eq("Public")
    end
  end

  it "returns rawr if scary" do
      item = Item.create(name: 'school', type: false)
      expect(school.school_type).to eq("Private")
  end
end
