require 'rails_helper'

RSpec.describe "As a Visitor" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  end

  it "see all items that I have added to my cart with item info" do
    visit "/items/#{@tire.id}"

    within "#item-#{@tire.id}" do
      click_button "Add to Cart"
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-#{@pull_toy.id}" do
      click_button "Add to Cart"
    end

    visit "/cart"

    # quantity_tire
    # quantity_pulltoy

    subtotal_tire = @tire.price * quantity_tire
    subtotal_pulltoy = @pull_toy.price * quantity_pulltoy
    grand_total = subtotal_tire + subtotal_pulltoy

    expect(page).to have_content(@tire.name)
    expect(page).to have_css("img[src*='#{@tire.image}']")
    expect(page).to have_content(@tire.merchant.name)
    expect(page).to have_content(@tire.price)
    expect(page).to have_content(quantity_tire)
    expect(page).to have_content(subtotal_tire)

    expect(page).to have_content(@pull_toy.name)
    expect(page).to have_css("img[src*='#{@pull_toy.image}']")
    expect(page).to have_content(@pull_toy.merchant.name)
    expect(page).to have_content(@pull_toy.price)
    expect(page).to have_content(quantity_pulltoy)
    expect(page).to have_content(subtotal_pulltoy)

    expect(page).to have_content(grand_total)
  end

end
