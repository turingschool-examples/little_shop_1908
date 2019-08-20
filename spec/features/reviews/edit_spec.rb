require 'rails_helper'

describe "Review Edit Page" do
  before(:each) do
    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    @review_1 = @pull_toy.reviews.create(title: "This toy rules", content: "I bought this for my dog and it rules", rating: 5)
  end

  xit 'has a form to update a review with prepopulated info' do
    visit "/items/#{@pull_toy.id}/reviews/#{@review_1.id}/edit-review"

    expect(find_field('Title').value).to eq(@review_1.title)
    expect(find_field('Content').value).to eq(@review_1.content)
    expect(find_field('Rating').value).to eq(@review_1.rating)

    title = "It broke! :("
    content = "My dog loved this until it broke."

    fill_in 'Title', with: title
    fill_in 'Content', with: content
    find("#rating").click
    find("#rating option", :text => '3').click

    click_button "Submit Updated Review"

    expect(current_path).to eq("/items/#{@pull_toy.id}")
    expect(page).to have_content(title)
    expect(page).to_not have_content("This toy rules")
    expect(page).to have_content(content)
    expect(page).to_not have_content("I bought this for my dog and it rules")
    expect(page).to have_content("3")
  end
end
