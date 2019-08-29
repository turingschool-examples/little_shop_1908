# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Two Tired Bike Emporium", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "The Notorious D.O.G. Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
lights = bike_shop.items.create!(name: "Bike Lights", description: "So bright!", price: 25, image: "https://images-na.ssl-images-amazon.com/images/I/81NBFtp5HGL._SL1500_.jpg", inventory: 24)

#tire reviews
review_1 = tire.reviews.create!(title: "Hooray", content: "I like this tire!", rating: 4)
review_2 = tire.reviews.create!(title: "Omg!", content: "It IS a tire!!", rating: 3)
review_3 = tire.reviews.create!(title: "Celebration!", content: "I can ride my bike now!", rating: 5)
review_4 = tire.reviews.create!(title: "Hard Pass", content: "No one told me I had to buy two.", rating: 1)

#chain reviews
review_1 = chain.reviews.create!(title: "Great", content: "I like this chain!", rating: 4)
review_2 = chain.reviews.create!(title: "Win!", content: "It IS a chain!!", rating: 5)
review_3 = chain.reviews.create!(title: "Yay", content: "I can ride my bike now!", rating: 5)
review_4 = chain.reviews.create!(title: "No Way!", content: "The worst", rating: 1)
review_5 = chain.reviews.create!(title: "Not Mad, Just Disappointed", content: "I just want to ride my bicycle", rating: 2)
review_6 = chain.reviews.create!(title: "Womp Womp", content: "I hate it", rating: 1)

#lights reviews
review_1 = lights.reviews.create!(title: "Confused", content: "Why is my light red? I don't understand.", rating: 2)
review_2 = lights.reviews.create!(title: "Full package!", content: "It came with both lights!!", rating: 3)
review_3 = lights.reviews.create!(title: "Night Vision OH YEAH", content: "I can ride my bike at night now!", rating: 5)
review_4 = lights.reviews.create!(title: "These broke my nose", content: "I didn't see the ditch last night.", rating: 1)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
oh_canada = dog_shop.items.create(name: "Canada Day Outfit", description: "Help your doggo be on their 'eh' game for Canada Day!", price: 35, image: "http://4.bp.blogspot.com/-vus58KIbKAo/UdDSnMEq-yI/AAAAAAAAD3o/kG2dY-wog4Y/s500/dooq+Foter.com+CC+BY-NC-SA.jpg", active?:true, inventory: 4)

#pull_toy reviews
review_1 = pull_toy.reviews.create!(title: "So fun!", content: "This keeps my dog entertained for MINUTES!", rating: 4)
review_1 = pull_toy.reviews.create!(title: "Meh", content: "My dog doesn't like playing with this on his own.", rating: 2)
review_1 = pull_toy.reviews.create!(title: "She loves it!", content: "This keeps my dog Phoebe from running away while we play!", rating: 5)
review_1 = pull_toy.reviews.create!(title: "Not for large dogs", content: "It snapped within 5 uses with my huge doggo.", rating: 1)

#dog_bone reviews
review_1 = dog_bone.reviews.create!(title: "Arf!", content: "My doggo is a happy doggo!", rating: 5)
review_1 = dog_bone.reviews.create!(title: "More like an amuse bouche than a bone...", content: "My dog ate the whole thing in minutes.", rating: 2)
review_1 = dog_bone.reviews.create!(title: "He loves it!", content: "This keeps my dog Whiskey entertained while I'm out with friends at dog-friendly bars!", rating: 5)
review_1 = dog_bone.reviews.create!(title: "Incentivizer!", content: "It keeps my dog Lemon in check when she's going after my plants", rating: 4)

#oh_canada reviews
review_1 = oh_canada.reviews.create!(title: "Oh Canada indeed!", content: "What an amazing outfit to celebrate Canada Day!", rating: 5)
review_1 = oh_canada.reviews.create!(title: "SO CUTE", content: "Tango was the most popular at our Canada Day party with this one!", rating: 5)
review_1 = oh_canada.reviews.create!(title: "I am very amoosed by this costume!", content: "I'm not sure if Larry loves this as much as we do, but we love dressing him in it!", rating: 5)
