require 'rails_helper'

RSpec.describe "item edit" do
  describe "when I visit an item show page and click on edit item" do

    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      visit "/items/#{@tire.id}"
      click_link "Edit Item"
    end

    it 'can see the prepopulated fields of that item' do
      expect(current_path).to eq("/items/#{@tire.id}/edit")
      expect(page).to have_link("Gatorskins")
      expect(find_field('Name').value).to eq "Gatorskins"
      expect(find_field('Price').value).to eq '100.0'
      expect(find_field('Description').value).to eq "They'll never pop!"
      expect(find_field('Image').value).to eq("https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588")
      expect(find_field('Inventory').value).to eq '12'
    end

    it 'I can change and update item with the form' do
      fill_in 'Name', with: "GatorSkins"
      fill_in 'Price', with: 110
      fill_in 'Description', with: "They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail."
      fill_in 'Image', with: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588"
      fill_in 'Inventory', with: 11

      click_button "Update Item"

      expect(current_path).to eq("/items/#{@tire.id}")
      expect(page).to have_content("GatorSkins")
      expect(page).to_not have_content("Gatorskins")
      expect(page).to have_content("Price: $110")
      expect(page).to have_content("Inventory: 11")
      expect(page).to_not have_content("Inventory: 12")
      expect(page).to_not have_content("Price: $100")
      expect(page).to have_content("They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail.")
      expect(page).to_not have_content("They'll never pop!")
    end

    describe 'invalid form inputs' do
      it 'shows a flash message when form is not filled out' do
        fill_in 'Name', with: nil
        fill_in 'Price', with: nil
        fill_in 'Description', with: nil
        fill_in 'Image', with: nil
        fill_in 'Inventory', with: nil

        click_button 'Update Item'

        expect(current_path).to eq("/items/#{@tire.id}/edit")
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Price can't be blank")
        expect(page).to have_content("Image can't be blank")
        expect(page).to have_content("Inventory can't be blank")
      end

      it 'must have proper data types' do
        fill_in 'Name', with: nil
        fill_in 'Price', with: "7asdf"
        fill_in 'Description', with: nil
        fill_in 'Image', with: nil
        fill_in 'Inventory', with: "hello"

        click_button 'Update Item'

        expect(current_path).to eq("/items/#{@tire.id}/edit")
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Price is not a number")
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Image can't be blank")
        expect(page).to have_content("Inventory is not a number")
      end
    end
  end
end
