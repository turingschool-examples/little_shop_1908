require 'rails_helper'

describe ItemOrder, type: :model do
  describe "relationships" do
    it {should belong_to :items}
    it {should belong_to :orders}
  end
end
