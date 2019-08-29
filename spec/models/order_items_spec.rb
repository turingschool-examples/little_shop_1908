require 'rails_helper'

RSpec.describe OrderItem do
  describe 'relationships' do
    it {should belong_to :order}
    it {should belong_to :item}
  end

  describe 'validations' do 
    it { should validate_presence_of :order}
    it { should validate_presence_of :item }
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end
end
