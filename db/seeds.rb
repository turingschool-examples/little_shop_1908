# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
music_shop = Merchant.create(name: "Dan's Music Shop", address: '41 Tune Ave.', city: 'Denver', state: 'CO', zip: 80201)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
handlebar = bike_shop.items.create(name: "Handlebar", description: "Comfort and control", price: 50, image: "https://www.rei.com/media/039d307a-7b41-4abb-b245-f4af4fb4f321?size=784x588", inventory: 4)
saddle = bike_shop.items.create(name: "Saddle", description: "Sporty!", price: 120, image: "https://www.rei.com/media/f1b712ba-7118-4861-ac72-cf023c92f048?size=784x588", inventory: 9)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
kong = dog_shop.items.create(name: "KONG", description: "Fun to chew!", price: 13, image: "https://images-na.ssl-images-amazon.com/images/I/71UdnSimAhL._AC_SX679_.jpg", inventory: 21)

#music_shop items
guitar_strings = music_shop.items.create(name: "Guitar Strings", description: "Rich and clear!", price: 9, image: "https://images-na.ssl-images-amazon.com/images/I/81KtifFUPQL._AC_SX679_.jpg", inventory: 32)
drum_sticks = music_shop.items.create(name: "Drum Sticks", description: "High quality!", price: 21, image: "https://images-na.ssl-images-amazon.com/images/I/51csSGxCa2L._AC_SL1005_.jpg", inventory: 21)

#reviews
review_1 = tire.reviews.create(title: "Amazing!", content: "I'll never buy a different brand.", rating: 5)
review_2 = tire.reviews.create(title: "Pretty good", content: "Overall, I'm satisfied.", rating: 4)
review_3 = tire.reviews.create(title: "Average", content: "Mediocre quality for the price.", rating: 3)
review_4 = tire.reviews.create(title: "So so", content: "Only ok.", rating: 3)
review_5 = tire.reviews.create(title: "Horrible!", content: "Really awful product!", rating: 1)
review_6 = tire.reviews.create(title: "Poor", content: "Unsatisfied.", rating: 2)
review_7 = tire.reviews.create(title: "Superb!", content: "The best ever.", rating: 5)
review_8 = pull_toy.reviews.create(title: "Fun!", content: "My dog loveed it!", rating: 4)
review_9 = drum_sticks.reviews.create(title: "Solid product!", content: "Would buy again.", rating: 4)
review_10 = drum_sticks.reviews.create(title: "These ROCK!", content: "I even bought my mom a pair.", rating: 5)

#orders
order_1 = Order.create(name: "Bob Newhouse", address: "123 Market Street", city: "Denver", state: "CO", zip: "80232", grand_total: 570, verification: "a12345678z")
item_order_1a = ItemOrder.create(order_id: order_1.id, item_id: tire.id, subtotal: 400, quantity: 4)
item_order_1b = ItemOrder.create(order_id: order_1.id, item_id: handlebar.id, subtotal: 50, quantity: 1)
item_order_1c = ItemOrder.create(order_id: order_1.id, item_id: saddle.id, subtotal: 120, quantity: 1)

order_2 = Order.create(name: "Lucy Harrison", address: "700 Harbor Avenue", city: "Boston", state: "MA", zip: "02108", grand_total: 44, verification: "55d4fcbdc7")
item_order_2a = ItemOrder.create(order_id: order_2.id, item_id: dog_bone.id, subtotal: 21, quantity: 1)
item_order_2b = ItemOrder.create(order_id: order_2.id, item_id: kong.id, subtotal: 13, quantity: 1)

order_3 = Order.create(name: "Sam Goldman", address: "330 Alamo Drive", city: "Dallas", state: "TS", zip: "75001", grand_total: 84, verification: "30f368f438")
item_order_3a = ItemOrder.create(order_id: order_3.id, item_id: drum_sticks.id, subtotal: 21, quantity: 4)

order_4 = Order.create(name: "Sam Goldman", address: "330 Alamo Drive", city: "Dallas", state: "TS", zip: "75001", grand_total: 20, verification: "30f368f438")
item_order_4a = ItemOrder.create(order_id: order_4.id, item_id: pull_toy.id, subtotal: 10, quantity: 2)
