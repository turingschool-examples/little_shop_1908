require 'rails_helper'

describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_inclusion_of(:rating).in_range(1..5) }
  end

  describe 'relationships' do
    it { should belong_to :item }
  end
end
