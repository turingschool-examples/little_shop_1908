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
    it { should have_many :reviews }
    it { should have_many :item_orders }
    it { should have_many(:orders).through(:item_orders) }
  end

  describe 'methods' do
    before(:each) do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @chain = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      @review_1 = @chain.reviews.create(title: 'Awesome', content: 'Really really awesome', rating: 5)
      @review_2 = @chain.reviews.create(title: 'Not Great', content: 'Stinks a lot', rating: 1)
      @review_3 = @chain.reviews.create(title: 'Mediocre', content: 'What can I say? Gets the job done I guess.', rating: 3)
      @review_4 = @chain.reviews.create(title: 'Good', content: 'Good product. Satisfied.', rating: 4)
    end

    describe 'top_three_reviews' do
      it 'shows the top 3 reviews for an item' do
        expect(@chain.top_three_reviews).to eq([@review_1, @review_4, @review_3])
      end
    end

    describe 'bottom_three_reviews' do
      it 'shows the bottomw 3 reviews for an item' do
        expect(@chain.bottom_three_reviews).to eq([@review_2, @review_3, @review_4])
      end
    end

    describe 'average_review_rating' do
      it 'shows the average rating for all reviews of an item' do
        expect(@chain.average_review_rating).to eq(3.25)
      end
    end

    describe 'ordered?' do
      it 'returns a boolean if the item has been ordered or not' do
        expect(@chain.ordered?).to eq(false)
      end
    end
  end
end
