require 'rails_helper'

RSpec.describe Cart do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @cart = Cart.new({})
  end


  subject { Cart.new({"4" => "3", "9" => "100"}) }

  it "can initialize with no contents" do
    cart = Cart.new(nil)

    expect(cart.contents).to eq({})
  end

  it "can initialize with contents" do
    expect(subject.contents).to eq({"4" => "3", "9" => "100"})
  end

  it "can report the quantity of a item" do
    expect(subject.quantity_of(4)).to eq(3)
  end

  it "can add a new item" do
    subject.add_item(5)
    expect(subject.quantity_of(5)).to eq(1)
  end

  it "can calculate total_count" do
    subject_2 = Cart.new({"4" => 3, "9" => 100})
    expect(subject_2.total_count).to eq(103)
  end

  it "can calculate subtotal of an item" do
    @cart.add_item(@tire.id)
    @cart.add_item(@tire.id)
    expect(@cart.subtotal_item(@tire.id.to_s)).to eq(200)
  end

  it "can calculate grand total of a cart" do
    @cart.add_item(@tire.id)
    @cart.add_item(@tire.id)
    @cart.add_item(@pull_toy.id)
    expect(@cart.grand_total).to eq(210)
  end
end
