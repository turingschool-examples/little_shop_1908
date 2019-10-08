FactoryBot.define do

  factory :merchant do
    factory :pauls_pizza do
      name { "Pauls Pizza" }
      address { '123 Pizza Rd.' }
      city { 'Pizza' }
      state { 'Italy' }
      zip { 1345 }
    end

    factory :brians_bike_shop do
      name { "Brian's Bike Shop" }
      address { '123 Bike Rd.' }
      city { 'Richmond' }
      state { 'VA' }
      zip { 11234 }
    end
  end

  factory :item do
    factory :chain do
      name { "Chain" }
      description { "It'll never break!" }
      price { 50 }
      image { "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588" }
      inventory { 5 }
      merchant { build(:brians_bike_shop) }
    end

    factory :garlic_knots do
      name { "Garlic Knots" }
      description { "Garlicy and Buttery" }
      price { 2 }
      image { "https://www.dinneratthezoo.com/wp-content/uploads/2017/12/garlic-knots-4.jpg" }
      inventory { 12 }
      merchant { build(:pauls_pizza) }
    end
  end


  factory :review do
    chain = FactoryBot.create(:chain)
    factory :chain_review_1 do
      title { "Best Chain evur" }
      content { "It never broke!" }
      rating { 5 }
      item { chain }
    end

    factory :chain_review_2 do
      title { "Wurst Chain evur" }
      content { "It broke!" }
      rating { 1 }
      item { chain }
    end
  end
end
