require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do

  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: '23137')
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @dog_bone = @meg.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
  end

  it 'can see a merchants name, address, city, state, zip' do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_content("Brian's Bike Shop")
    expect(page).to have_content("123 Bike Rd. Richmond, VA 23137")
  end

  it 'can see a link to visit the merchant items' do
    visit "/merchants/#{@bike_shop.id}"
    click_link "All #{@bike_shop.name} Items"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
  end

  it 'flashes an error and redirects to index if no merchant exists' do
    visit '/merchants/2'

    expect(page).to have_content('Merchant does not exist')
    expect(current_path).to eq('/merchants')
  end

  it 'can see the total number of items a merchant has' do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_content("Total Items: 1")

    @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit "/merchants/#{@bike_shop.id}"

    within '#statistics' do
      expect(page).to have_content("Total Items: 2")
    end
  end

  it 'can see the average price of all their items' do
    @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    visit "/merchants/#{@bike_shop.id}"

    within '#statistics' do
      expect(page).to have_content("Average Item Price: $66.67")
    end
  end

  it 'can show a list of distinct cities where their items have been ordered' do
    user_1 = User.create(name: 'Kyle Pine', address: '123 Main Street', city: 'Greenville', state: 'NC', zip: '29583')
    order_1 = user_1.orders.create(grand_total: 100, verification_code: '4856752493')
    order_1.item_orders.create(item_id: @tire.id, item_quantity: 2, subtotal: 50)

    user_2 = User.create(name: 'Steve Spruce', address: '456 2nd Street', city: 'Redville', state: 'SC', zip: '29444')
    order_2 = user_2.orders.create(grand_total: 40, verification_code: '6856758493')
    order_2.item_orders.create(item_id: @pull_toy.id, item_quantity: 2, subtotal: 20)
    order_2.item_orders.create(item_id: @dog_bone.id, item_quantity: 1, subtotal: 20)

    user_3 = User.create(name: 'Steve Spruce', address: '456 2nd Street', city: 'Redville', state: 'SC', zip: '29444')
    order_3 = user_3.orders.create(grand_total: 40, verification_code: '3156408493')
    order_3.item_orders.create(item_id: @pull_toy.id, item_quantity: 2, subtotal: 20)
    order_3.item_orders.create(item_id: @dog_bone.id, item_quantity: 1, subtotal: 20)

    visit "/merchants/#{@meg.id}"

    within '#statistics' do
      expect(page).to have_content('Items sold in these cities:')
      expect(page).to have_content('Greenville, NC')
      expect(page).to have_content('Redville, SC')
    end
  end

  it 'should not display cities if a merchant has no orders' do
    visit "/merchants/#{@bike_shop.id}"

    within '#statistics' do
      expect(page).to have_content('No items have been sold 🥺')
    end
  end

  it 'shows the merchants top three items by average review rating' do
    @tire.reviews.create(title: 'Great tire.', content: 'Really fills up.', rating: 4)
    @tire.reviews.create(title: 'Awesome', content: 'Love this tire!', rating: 5)
    @pull_toy.reviews.create(title: 'Less than ideal', content: 'Popped', rating: 2)
    @dog_bone.reviews.create(title: 'Not quite round', content: 'Really close though', rating: 3)

    visit "/merchants/#{@meg.id}"

    expect(page).to have_content('Top Rated Items')

    expect(page.find_all('.top-three-items')[0]).to have_content(@tire.name)
    expect(page.find_all('.top-three-items')[0]).to have_css("img[src='#{@tire.image}']")
    expect(page.find_all('.top-three-items')[0]).to have_content('Average Review Rating: 4.5')

    expect(page.find_all('.top-three-items')[1]).to have_content(@dog_bone.name)
    expect(page.find_all('.top-three-items')[1]).to have_css("img[src='#{@dog_bone.image}']")
    expect(page.find_all('.top-three-items')[1]).to have_content('Average Review Rating: 3')

    expect(page.find_all('.top-three-items')[2]).to have_content(@pull_toy.name)
    expect(page.find_all('.top-three-items')[2]).to have_css("img[src='#{@pull_toy.image}']")
    expect(page.find_all('.top-three-items')[2]).to have_content('Average Review Rating: 2')
  end

  it 'does not show top rated items if a merchant has no items' do
    @meg.items.destroy_all

    visit "/merchants/#{@meg.id}"

    expect(page).to_not have_content('Top Rated Items')
    expect(page).to_not have_css('.top-three-items')
  end
end
