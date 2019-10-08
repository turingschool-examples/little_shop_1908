require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_presence_of :rating }
  end

  describe "relationships" do
    it { should belong_to :item }
  end

  describe 'instance methods' do

    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @great = @tire.reviews.create(title: 'Great tire.', content: 'Really fills up.', rating: 4)
      @less_than_ideal = @tire.reviews.create(title: 'Less than ideal', content: 'Popped', rating: 1)
      @not_round = @tire.reviews.create(title: 'Not quite round', content: 'Really close though', rating: 3)
      @wrong_size = @tire.reviews.create(title: 'Not the right size', content: 'Misleading description', rating: 1)
      @awesome = @tire.reviews.create(title: 'Awesome', content: 'Love this tire!', rating: 5)
    end

    it 'can retrieve the top three reviews' do
      expect(@tire.reviews.top_three).to eq([@awesome, @great, @not_round])
    end

    it 'can retrieve the bottom three reviews' do
      expect(@tire.reviews.bottom_three).to eq([@less_than_ideal, @wrong_size, @not_round])
    end

    it 'can calculate the average review rating' do
      expect(@tire.reviews.average_rating).to eq(2.8)
    end
  end

end
