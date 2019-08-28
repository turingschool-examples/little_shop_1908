require 'rails_helper'

describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_numericality_of(:rating) }
  end

  describe 'relationships' do
    it { should belong_to :item }
  end

  describe 'class methods' do
    it "sort_reviews" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      review_1 = tire.reviews.create(title: 'Its Great!', content: 'Best tire ever!', rating: 5)
      review_2 = tire.reviews.create(title: 'Its awful!', content: 'I hate it!', rating: 1)
      review_3 = tire.reviews.create(title: 'Its okay!', content: 'Mediocre at best...', rating: 3)
      review_4 = tire.reviews.create(title: "It's pretty good", content: 'Maybe a little pricey, but they sure work good.', rating: 2)
      review_5 = tire.reviews.create(title: "It's pretty decent", content: 'Lasted a pretty long time on my last set', rating: 4)

      expect(Review.sort_reviews('max-rating', tire.id)).to eq([review_1, review_5, review_3, review_4, review_2])
      expect(Review.sort_reviews('min-rating', tire.id)).to eq([review_2, review_4, review_3, review_5, review_1])
      expect(Review.sort_reviews('date-asc', tire.id)).to eq([review_1, review_2, review_3, review_4, review_5])
      expect(Review.sort_reviews('date-desc', tire.id)).to eq([review_5, review_4, review_3, review_2, review_1])
    end
  end
end
