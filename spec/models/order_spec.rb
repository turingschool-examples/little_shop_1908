require 'rails_helper'

describe Order, type: :model do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'relationship' do
    it {should have_many :items_orders}
    it {should have_many(:items).through(:items_orders)}
  end

describe "instance methods" do
  before(:each) do
    @brian = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @tire = @brian.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
    @pull_toy = @brian.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @order = Order.create!(name: "Bob", address: '123 Bob Rd.', city: 'Denver', state: 'CO', zip: "82222")
    @pull_toy.orders << @order
    @tire.orders << @order
  end

  it "can calculate subtotal of an item" do
    # binding.pry

    expect(@order.show_subtotal(ItemsOrder.new({quantity: 2}), @pull_toy)).to eq(20)
  end

  it "can calculate grand total of a cart" do
    ItemsOrder.where(item_id: @pull_toy.id).where(order_id: @order.id).update({quantity: 1})
    ItemsOrder.where(item_id: @tire.id).where(order_id: @order.id).update({quantity: 2})
    expect(@order.show_grand_total).to eq(210)
  end
end
end
