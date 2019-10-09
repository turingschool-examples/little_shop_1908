require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should_not allow_value(nil).for(:active?) }
    
    it { should validate_numericality_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:inventory).only_integer }
    it { should validate_numericality_of(:inventory).is_greater_than(0) }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :reviews }
  end
end
