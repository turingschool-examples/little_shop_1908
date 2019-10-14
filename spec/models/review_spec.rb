require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_presence_of :rating }
    it { should validate_numericality_of(:rating).
          only_integer.
          is_less_than_or_equal_to(5).
          is_greater_than_or_equal_to(1)
        }
  end

  describe "relationships" do
    it { should belong_to :item }
  end

  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create(title: "first review", content: "content", rating: 4)
    @review_2 = @chain.reviews.create(title: "second review", content: "more content", rating: 5)
    @review_3 = @chain.reviews.create(title: "third review", content: "more content", rating: 4)
    @review_4 = @chain.reviews.create(title: "fourth review", content: "more content", rating: 3)
    @review_5 = @chain.reviews.create(title: "fifth review", content: "more content", rating: 1)
    @review_6 = @chain.reviews.create(title: "sixth review", content: "more content", rating: 2)
    @review_7 = @chain.reviews.create(title: "seventh review", content: "more content", rating: 2)
  end

  it "can calculate the average rating of all reviews" do
    expect(Review.avg_rating).to eq(3.00)
  end

  it "can identify the 3 lowest rated reviews" do
    expect(Review.bottom).to eq([@review_5, @review_6, @review_7])
  end

  it "can identify the 3 highest rated reviews" do
    expect(Review.top).to eq([@review_2, @review_3, @review_1])
  end
end
