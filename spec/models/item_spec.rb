require 'rails_helper'

describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'item instance methods' do
  before :each do
    @scott = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @FFX_game = @scott.items.create!(name: 'FFX', description: "FFX For PS4", price: 20, image: 'https://upload.wikimedia.org/wikipedia/en/a/a7/Ffxboxart.jpg', active?: true, inventory: 3)
    @rev_1 = @FFX_game.reviews.create!(title: 'My thoughts', content: 'Engaging Video Game!', rating: 5)
    @rev_2 = @FFX_game.reviews.create!(title: 'My other thoughts', content: 'Awesome Video Game!', rating: 4)
    @rev_3 = @FFX_game.reviews.create!(title: 'My other other thoughts', content: 'Guilty pleasure Video Game!', rating: 3)
  end

  describe "sort_reviews" do
    it "sorts reviews by rating descending" do
        expect(@FFX_game.sort_reviews(3, :desc)).to eq([@rev_1,@rev_2,@rev_3])
      end
      it "sorts reviews by rating ascending" do
        expect(@FFX_game.sort_reviews(3, :asc)).to eq([@rev_3,@rev_2,@rev_1])
      end
    end

  describe "average_rating" do
    it "gets the average rating of reviews"do
    expect(@FFX_game.average_rating).to eq(4)
  end
  end

  describe "has_orders?" do
     it "verifies if item is currently on an order"do
       expect(@FFX_game.has_orders?).to eq(true)
       @order = Order.create!(username: 'Christopher', address: '123 Oak', city: 'Denver', state: 'CO', zipcode: 80021)
       @order.order_items.create!(item: @FFX_game, price: @FFX_game.price, quantity: 1)
       expect(@FFX_game.has_orders?).to eq(false)
     end
   end
end
end
