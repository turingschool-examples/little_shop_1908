require 'rails_helper'

RSpec.describe "As a Visitor" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @cart = Cart.new({})
  end

  it "see all items that I have added to my cart with item info" do
    visit "/items/#{@tire.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@tire.id)
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@pull_toy.id)
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@pull_toy.id)
    end

    visit "/cart"

    quantity_tire = @cart.quantity_of(@tire.id)
    quantity_pulltoy = @cart.quantity_of(@pull_toy.id)

    subtotal_tire = @tire.price * quantity_tire
    subtotal_pulltoy = @pull_toy.price * quantity_pulltoy
    grand_total = subtotal_tire + subtotal_pulltoy

    # save_and_open_page

    expect(page).to have_content(@tire.name)
    expect(page).to have_css("img[src*='#{@tire.image}']")
    expect(page).to have_content("Sold by: #{@tire.merchant.name}")
    expect(page).to have_content("Price: $#{@tire.price}")
    expect(page).to have_content("Quantity: #{quantity_tire}")
    expect(page).to have_content("Subtotal: $#{subtotal_tire}")

    expect(page).to have_content(@pull_toy.name)
    expect(page).to have_css("img[src*='#{@pull_toy.image}']")
    expect(page).to have_content("Sold by: #{@pull_toy.merchant.name}")
    expect(page).to have_content("Price: $#{@pull_toy.price}")
    expect(page).to have_content("Quantity: #{quantity_pulltoy}")
    expect(page).to have_content("Subtotal: $#{subtotal_pulltoy}")

    expect(page).to have_content("Grand Total: $#{grand_total}")
  end

  it "see all items that I have added to my cart with item info" do
    visit "/cart"


    expect(page).to have_content("Your cart is empty")
    expect(page).to_not have_link("Empty Cart")
  end

  it "can empty cart" do
    visit "/items/#{@tire.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@tire.id)
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@pull_toy.id)
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@pull_toy.id)
    end

    visit "/cart"

    click_on "Empty Cart"

    quantity_tire = @cart.quantity_of(@tire.id)
    quantity_pulltoy = @cart.quantity_of(@pull_toy.id)

    subtotal_tire = @tire.price * quantity_tire
    subtotal_pulltoy = @pull_toy.price * quantity_pulltoy
    grand_total = subtotal_tire + subtotal_pulltoy


    expect(page).to_not have_content(@tire.name)
    expect(page).to_not have_css("img[src*='#{@tire.image}']")
    expect(page).to_not have_content("Sold by: #{@tire.merchant.name}")
    expect(page).to_not have_content("Price: $#{@tire.price}")
    expect(page).to_not have_content("Quantity: #{quantity_tire}")
    expect(page).to_not have_content("Subtotal: $#{subtotal_tire}")

    expect(page).to_not have_content(@pull_toy.name)
    expect(page).to_not have_css("img[src*='#{@pull_toy.image}']")
    expect(page).to_not have_content("Sold by: #{@pull_toy.merchant.name}")
    expect(page).to_not have_content("Price: $#{@pull_toy.price}")
    expect(page).to_not have_content("Quantity: #{quantity_pulltoy}")
    expect(page).to_not have_content("Subtotal: $#{subtotal_pulltoy}")

    expect(page).to_not have_content("Grand Total: $#{grand_total}")

    expect(page).to have_content("Your cart is empty")
    expect(page).to_not have_link("Empty Cart")

    expect(page).to have_content("Cart: 0")

  end


  it "can remove an item from cart" do
    visit "/items/#{@tire.id}"

    within "#item-info" do
      click_on "Add to Cart"
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
    end

    quantity_tire = @cart.quantity_of(@tire.id)
    quantity_pulltoy = @cart.quantity_of(@pull_toy.id)

    subtotal_tire = @tire.price * quantity_tire
    subtotal_pulltoy = @pull_toy.price * quantity_pulltoy
    grand_total = subtotal_tire + subtotal_pulltoy

    visit "/cart"

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_link("Remove Item")
      click_link "Remove Item"
    end

    expect(page).to_not have_content(@tire.name)
    expect(page).to_not have_css("img[src*='#{@tire.image}']")
    expect(page).to_not have_content("Sold by: #{@tire.merchant.name}")
    expect(page).to_not have_content("Price: $#{@tire.price}")
    expect(page).to_not have_content("Quantity: #{quantity_tire}")
    expect(page).to_not have_content("Subtotal: $#{subtotal_tire}")
  end

  it "quantity of item is increased in cart" do
    visit "/items/#{@tire.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@tire.id)
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@pull_toy.id)
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@pull_toy.id)
    end

    visit "/cart"

    quantity_tire = @cart.quantity_of(@tire.id)

    within "#cart-item-#{@tire.id}" do
      expect(page).to have_button("+")
      expect(page).to have_content("Quantity: 1")

      click_button "+"
      #@cart.increase_quantity(@tire.id.to_s)

      expect(page).to have_content("Quantity: 2")
    end
  end

  it "quantity of item cannot be increased in cart beyond item inventory size" do
    visit "/items/#{@tire.id}"

    within "#item-info" do
      click_on "Add to Cart"
      @cart.add_item(@tire.id)
    end

    visit "/cart"

    within "#cart-item-#{@tire.id}" do
      click_button "+"
      click_button "+"
      expect(page).to have_content("Quantity: 2")
    end

    expect(page).to have_content("There is no more inventory for #{@tire.name}")
  end

  it "quantity of item is decreased in cart" do
    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
    end

    visit "/items/#{@pull_toy.id}"

    within "#item-info" do
      click_on "Add to Cart"
    end

    visit "/cart"

    within "#cart-item-#{@pull_toy.id}" do
      expect(page).to have_button("-")
      expect(page).to have_content("Quantity: 2")

      click_button "-"
    end

    visit "/cart"

    expect(page).to have_content("Quantity: 1")

    within "#cart-item-#{@pull_toy.id}" do
      click_button "-"
    end

    visit "/cart"

    quantity_pulltoy = @cart.quantity_of(@pull_toy.id)
    subtotal_pulltoy = @pull_toy.price * quantity_pulltoy

    expect(page).to_not have_content(@pull_toy.name)
    expect(page).to_not have_css("img[src*='#{@pull_toy.image}']")
    expect(page).to_not have_content("Sold by: #{@pull_toy.merchant.name}")
    expect(page).to_not have_content("Price: $#{@pull_toy.price}")
    expect(page).to_not have_content("Quantity: #{quantity_pulltoy}")
    expect(page).to_not have_content("Subtotal: $#{subtotal_pulltoy}")
  end
end
