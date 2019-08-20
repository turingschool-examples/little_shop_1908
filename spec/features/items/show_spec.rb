require 'rails_helper'

describe 'Item Show Page' do
  before(:each) do
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    @review_1 = @pull_toy.reviews.create(title: "This toy rules", content: "I bought this for my dog and it rules", rating: 5)
    @review_2 = @pull_toy.reviews.create(title: "This toy sucks", content: "My dog hates this toy", rating: 1)
  end

  it "displays an item's name, description, price, image, status, inventory, and merchant" do
    visit "/items/#{@pull_toy.id}"

    expect(page).to have_link(@pull_toy.merchant.name)
    expect(page).to have_content(@pull_toy.name)
    expect(page).to have_content(@pull_toy.description)
    expect(page).to have_content("Price: $#{@pull_toy.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
    expect(page).to have_content("Sold by: #{@dog_shop.name}")
    expect(page).to have_css("img[src*='#{@pull_toy.image}']")
  end

  it 'displays reviews for that item' do
    visit "/items/#{@pull_toy.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.content)
      expect(page).to have_content(@review_1.rating)
    end

    within "#review-#{@review_2.id}" do
      expect(page).to have_content(@review_2.title)
      expect(page).to have_content(@review_2.content)
      expect(page).to have_content(@review_2.rating)
    end
  end

  it 'has a link to the merchant that sells the item' do
    visit "/items/#{@pull_toy.id}"

    expect(page).to have_link(@dog_shop.name)

    click_link "#{@dog_shop.name}"

    expect(current_path).to eq("/merchants/#{@dog_shop.id}")
  end

  it 'has a link to update the item' do
    visit "/items/#{@pull_toy.id}"

    expect(page).to have_link("Edit Item")

    click_link "Edit Item"

    expect(current_path).to eq("/items/#{@pull_toy.id}/edit")
  end

  describe 'has a link to delete the item' do
    it 'if the item has reviews' do
      visit "/items/#{@pull_toy.id}"

      expect(page).to have_link("Delete Item")

      click_link "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{@pull_toy.id}")
    end

    it 'if the item has no reviews' do
      dog_bone = @dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      visit "/items/#{dog_bone.id}"

      expect(page).to have_link("Delete Item")

      click_link "Delete Item"

      expect(current_path).to eq("/items")
      expect(page).to_not have_css("#item-#{dog_bone.id}")
    end
  end

  it 'has a link to add a review' do
    visit "/items/#{@pull_toy.id}"

    expect(page).to have_link("Add Review")

    click_link "Add Review"

    expect(current_path).to eq("/items/#{@pull_toy.id}/reviews/new-review")
  end

  it 'has a link to edit each review' do
    visit "/items/#{@pull_toy.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_link("Edit this Review")

      click_link "Edit this Review"
    end

    expect(current_path).to eq("/items/#{@pull_toy.id}/reviews/#{@review_1.id}/edit-review")

    visit "/items/#{@pull_toy.id}"

    within "#review-#{@review_2.id}" do
      expect(page).to have_link("Edit this Review")

      click_link "Edit this Review"
    end

    expect(current_path).to eq("/items/#{@pull_toy.id}/reviews/#{@review_2.id}/edit-review")
  end

  xit 'has a link to delete each review' do
    visit "/items/#{@pull_toy.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_link("Delete this Review")

      click_link "Delete this Review"
    end

    expect(current_path).to eq("/items/#{@pull_toy.id}")
    expect(page).to_not have_content(@review_1.title)
    expect(page).to_not have_content(@review_1.content)

    visit "/items/#{@pull_toy.id}"

    within "#review-#{@review_2.id}" do
      expect(page).to have_link("Delete this Review")

      click_link "Delete this Review"
    end

    expect(current_path).to eq("/items/#{@pull_toy.id}")
    expect(page).to_not have_content(@review_2.title)
    expect(page).to_not have_content(@review_2.content)
  end
end
