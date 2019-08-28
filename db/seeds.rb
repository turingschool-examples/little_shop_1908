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
chain = bike_shop.items.create(name: "Super Chain", description: "It'll never break!", price: 80, image: "https://images-na.ssl-images-amazon.com/images/I/91DPn4vp2ML._SX425_.jpg", inventory: 23)
lights = bike_shop.items.create(name: "Blinky Lights", description: "They are super bright and blinky!", price: 43.50, image: "https://images-na.ssl-images-amazon.com/images/I/81NBFtp5HGL._SX466_.jpg", inventory: 8)
horn = bike_shop.items.create(name: "Honky Horn", description: "Let everyone know you mean business!", price: 27.99, image: "https://static.evanscycles.com/production/bike-accessories/bells--horns/product-image/484-319/electra-bicycle-horn-black-silver-EV322701-8575-1.jpg", inventory: 4)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
collar = dog_shop.items.create(name: "Chaco Collar", description: "Dogs love name brand stuff too!", price: 35.79, image: "https://www.rei.com/media/3ef543ea-9b63-4f97-9c24-e5f2d4de4b85?size=784x588", active?:false, inventory: 21)

#tire reviews
tire_review_1 = tire.reviews.create(title: 'Its Great!', content: 'Best tire ever!', rating: 5)
tire_review_2 = tire.reviews.create(title: 'Its awful!', content: 'I hate it!', rating: 1)
tire_review_3 = tire.reviews.create(title: 'Its okay!', content: 'Mediocre at best...', rating: 3)
tire_review_4 = tire.reviews.create(title: "It's pretty good", content: 'Maybe a little pricey, but they sure work good.', rating: 4)
tire_review_5 = tire.reviews.create(title: "It's pretty decent", content: 'Lasted a pretty long time on my last set', rating: 4)

#chain reviews
chain_review_1 = chain.reviews.create(title: 'Its a chain!', content: 'Best chain ever!', rating: 5)
chain_review_2 = chain.reviews.create(title: 'Kinda heavy', content: 'Works great but yeah, its kina heavy', rating: 4)

#horn reviews
horn_review_1 = horn.reviews.create(title: 'Super cool!', content: 'It looks great and is super loud!', rating: 5)
horn_review_2 = horn.reviews.create(title: 'Stylish!', content: 'Everyone loves my honky horn!', rating: 5)

#lights review
lights_review_1 = lights.reviews.create(title: 'Lame', content: "They barely light up anything", rating: 1)
