# As a visitor,
# When I visit an item's show page
# I see a link to add a new review for this item.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - a review title
# - a numeric rating that can only be a number from 1 to 5
# - some text for the review itself
# When the form is submitted, I should return to that item's
# show page and I should see my review text.
require 'rails_helper'

RSpec.describe 
