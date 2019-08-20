require 'rails_helper'

describe Review do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :rating }
  end

  describe "relationships" do
    it { should belong_to :item }
  end
end
