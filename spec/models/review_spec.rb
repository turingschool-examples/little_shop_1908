require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :content }
    # https://github.com/thoughtbot/shoulda-matchers/blob/master/lib/shoulda/matchers/active_model/validate_numericality_of_matcher.rb
    it { should validate_numericality_of(:rating).only_integer }
    it do
      should validate_numericality_of(:rating).is_less_than(6)
      should validate_numericality_of(:rating).is_greater_than(0)
    end

  end

  describe "relationships" do
    it {should belong_to :item}
  end

  describe 'reviews methods' do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: 'Leiya', content: 'Awful chain, Meg lied to me!', rating: 1)
      @review_2 = @chain.reviews.create(title: 'Josh', content: "It wasn't that bad.", rating: 2)
      @review_3 = @chain.reviews.create(title: 'John', content: "I don't know why I bought a chain, I don't even use my bike", rating: 3)
      @review_4 = @chain.reviews.create(title: 'Evette', content: "Great chain! Used it to make an amazing collar for my pug Larry.", rating: 4)
      @review_5 = @chain.reviews.create(title: 'Meg', content: "I made this chain, it's great. Wish I could git it a 55/5", rating: 5)
    end
    it 'can get top three reviews' do
      expect(@chain.reviews.top_three).to eq([@review_5, @review_4, @review_3])
    end

    it 'can get bottom three reviews' do
      expect(@chain.reviews.bottom_three).to eq([@review_1, @review_2, @review_3])
    end
  end
end
