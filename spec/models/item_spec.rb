require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
  end

  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
    @review_2 = @chain.reviews.create!(title: "Win!", content: "It IS a chain!!", rating: 5)
    @review_3 = @chain.reviews.create!(title: "Yay", content: "I can ride my bike now!", rating: 5)
    @review_4 = @chain.reviews.create!(title: "No Way!", content: "The worst", rating: 1)
    @review_5 = @chain.reviews.create!(title: "Not Mad, Just Disappointed", content: "I just want to ride my bicycle", rating: 2)
    @review_6 = @chain.reviews.create!(title: "Womp Womp", content: "I hate it", rating: 1)
  end

  it "test top reviews" do
    expect(@chain.top_reviews).to eq([[@review_2.title, @review_2.rating, @review_2.content], [@review_3.title, @review_3.rating, @review_3.content], [@review_1.title, @review_1.rating, @review_1.content]])
  end

  it "test bottom reviews" do
    expect(@chain.bottom_reviews).to eq([[@review_4.title, @review_4.rating, @review_4.content], [@review_6.title, @review_6.rating, @review_6.content], [@review_5.title, @review_5.rating, @review_5.content]])
  end

  it "test average rating" do
    expect(@chain.average_rating).to eq(3)
  end

  it "test lowest reviews" do
    expect(@chain.lowest_reviews).to eq(@chain.lowest_reviews)
  end

  it "test highest reviews" do
    expect(@chain.highest_reviews).to eq(@chain.highest_reviews)
  end
end
