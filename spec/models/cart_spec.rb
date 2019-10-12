require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3, '3' => 4}) }

  describe "#total_count" do
    it "calculates the total number of items it holds" do
      expect(subject.total_count).to eq(9)
    end
  end

  describe "#add_item" do
    it "adds a item to its contents" do

      subject.add_item(1)
      subject.add_item(1)
      subject.add_item(1)
      subject.add_item(2)
      subject.add_item(3)
      subject.add_item(3)

      expect(subject.contents).to eq({'1' => 5, '2' => 4, '3' => 6})
    end
  end
end
