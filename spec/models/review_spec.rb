require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :content }
    # https://github.com/thoughtbot/shoulda-matchers/blob/master/lib/shoulda/matchers/active_model/validate_numericality_of_matcher.rb
    it { should validate_numericality_of(:rating).only_integer }
    it do
      should validate_numericality_of(:rating).is_less_than(6)
      should validate_numericality_of(:rating).is_greater_than(0)
    end

  end

  describe "relationships" do
    it {should belong_to :item}
  end
end
