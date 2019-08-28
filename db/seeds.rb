# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.destroy_all
Item.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
tire_review = tire.reviews.create(title: 'Never Buy This Tire', content: "I bought two of these and they blew within a week of each other, a month after purchase", rating: 1)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
pull_toy_review = pull_toy.reviews.create(title: "Sparky love this!", content: "Sparky took it right off the shelf and began playing with it immediately so I bought him 2!", rating: 5)

dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
dog_bone_review = dog_bone.reviews.create(title: 'What a dog bone!', content: "Taste great!", rating: 5)
dog_bone_review_2 = dog_bone.reviews.create(title: 'Title Example', content: "Taste great!", rating: 5)
# puts dog_bone_review_2.id

review_1 = tire.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 1)
review_2 = tire.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 2)
review_3 = tire.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 3)
review_4 = tire.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 4)
review_5 = tire.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 5)
review_6 = tire.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 1)
review_7 = tire.reviews.create(title: 'Review Title 7', content: "Content 7", rating: 2)
review_8 = tire.reviews.create(title: 'Review Title 8', content: "Content 8", rating: 3)
review_9 = tire.reviews.create(title: 'Review Title 9', content: "Content 9", rating: 4)
review_10 = tire.reviews.create(title: 'Review Title 10', content: "Content 10", rating: 5)
review_11 = tire.reviews.create(title: 'Review Title 11', content: "Content 11", rating: 1)
review_12 = tire.reviews.create(title: 'Review Title 12', content: "Content 12", rating: 1)
