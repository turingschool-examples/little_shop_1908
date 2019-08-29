require 'rails_helper'

describe Review do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_presence_of :rating }
  end

  describe 'relationships' do
    it { should belong_to :item }
  end

  describe 'inclusions' do
  it { validate_inclusion_of :in => 1..5 } 
  end
end
