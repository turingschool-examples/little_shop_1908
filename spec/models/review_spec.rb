require 'rails_helper'

describe Review, type: :model do
  before :each do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @review_1 = @tire.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 5)
    @review_2 = @tire.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 5)
    @review_3 = @tire.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 5)
    @review_4 = @tire.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 5)
    @review_5 = @tire.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 3)
    @review_6 = @tire.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 3)
    @review_7 = @tire.reviews.create(title: 'Review Title 7', content: "Content 7", rating: 3)
    @review_8 = @tire.reviews.create(title: 'Review Title 8', content: "Content 8", rating: 3)
    @review_9 = @tire.reviews.create(title: 'Review Title 9', content: "Content 9", rating: 1)
    @review_10 = @tire.reviews.create(title: 'Review Title 10', content: "Content 10", rating: 1)
    @review_11 = @tire.reviews.create(title: 'Review Title 11', content: "Content 11", rating: 1)
    @review_12 = @tire.reviews.create(title: 'Review Title 12', content: "Content 12", rating: 1)
  end
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_presence_of :rating }
  end

  describe 'relationships' do
    it { should belong_to :item }
 end

 describe 'testing method' do
   it 'can find avg rating' do

    expect(@tire.reviews.avg_rating).to eq(3)
  end

  it 'can find top three reviews' do
    expected =[ @review_1, @review_3, @review_2]

    expect(@tire.reviews.top_three_reviews).to eq(expected)
  end

  it 'can find bottom three reviews' do
    expected =[@review_9, @review_10, @review_11]

    expect(@tire.reviews.bottom_three_reviews).to eq(expected)
  end
 end
end
