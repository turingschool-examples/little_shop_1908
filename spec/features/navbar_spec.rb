describe 'From any page on the site' do
  it 'I see a cart indicator with how many items are in my cart' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    visit "/items/#{@tire.id}"

    within ".topnav" do
      expect(page).to have_content("Cart: 0")
    end

    click_on "Add to cart"

    expect(current_path).to eq("/items")
    expect(page).to have_content("#{@tire.name} added to cart")

    within ".topnav" do
      expect(page).to have_content("Cart: 1")
    end

    #Make test to verify all other pages display same values

  end
end
