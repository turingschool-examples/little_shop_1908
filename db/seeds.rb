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

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#tire reviews
review_1 = tire.reviews.create(title: "Worst tire!", content: "NEVER buy this tire.", rating: 1)
review_2 = tire.reviews.create(title: "Awesome tire!", content: "This was a great tire! Would buy again.", rating: 5)
review_3 = tire.reviews.create(title: "Meh", content: "I probably wouldn't buy this again.", rating: 3)
review_4 = tire.reviews.create(title: "Really Good Chain", content: "Can't wait to order more. I gave it a 4 because the order took long to process.", rating: 4)
review_5 = tire.reviews.create(title: "Disappointed", content: "Super disappointed in this tire. It broke after two uses! Don't buy.", rating: 2)
review_6 = tire.reviews.create(title: "Best tire EVER!", content: "I'm ordering this tire for everyone I know with a bike. That's how much I loved it!", rating: 5)
