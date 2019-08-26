require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
  end

  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @order = Order.create(nil)
  end

  it "test sold items" do
    expect(@bike_shop.sold_items?).to eq(false)
  end

  it "test count of items" do
    expect(@bike_shop.count_of_items).to eq(2)
  end

  it "test average price" do
    expect(@bike_shop.average_price).to eq(75)
  end

  it "test distinct cities" do
    expect(@bike_shop.distinct_cities).to eq([])
  end

  it "test top 3 items" do
    expect(@bike_shop.top_3_items).to eq([["Chain", nil], ["Gatorskins", nil]])
  end

end
