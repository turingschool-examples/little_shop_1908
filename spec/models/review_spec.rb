require 'rails_helper'

describe Review do
  describe "relationships" do
    it { should belong_to :item }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5).only_integer }
  end
end
