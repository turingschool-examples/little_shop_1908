require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of :grand_total }

    it { should validate_numericality_of(:grand_total) }
    it { should validate_numericality_of(:grand_total).is_greater_than(0) }
  end

  describe 'relationships' do
    it { should have_many :item_orders }
    it { should have_many :items }
  end

end