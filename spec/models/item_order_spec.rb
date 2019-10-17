require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  describe 'validations' do
    it { should validate_presence_of :item_quantity }
    it { should validate_presence_of :subtotal }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :order }
  end
end
