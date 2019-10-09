require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }

    it { should validate_numericality_of(:zip).only_integer }
    # it { should validate_length_of(:zip).is_equal_to(5) }
  end

  describe "relationships" do
    it {should have_many :items}
  end
end
