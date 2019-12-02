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
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
coffee_shop = Merchant.create(name: "Ian's Coffee Shop", address: '123 Coffee Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
plant_shop = Merchant.create(name: "Mike's Plant Shop", address: '125 Plant St.', city: 'Bost', state: 'MA', zip: 10001)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#plant_shop items
succulent = plant_shop.items.create(name: "Succulent", description: "It usually doesn't need much work!", price: 6, image: "https://www.westelm.com/weimgs/rk/images/wcm/products/201940/0898/img26c.jpg", inventory: 4)
pearl_plant = plant_shop.items.create(name: "Pearl Plant", description: "So cute!", price: 10, image: "https://cdn.shopify.com/s/files/1/1752/4567/products/string_of_pearls_300x300.png?v=1522299713", inventory: 9)

#coffee_shop items
cups = coffee_shop.items.create(name: "Cups", description: "It'll break if you drop it. Goes great with saucer.", price: 4, image: "http://cdn.shopify.com/s/files/1/0797/8219/products/acmedinersmall_grande.jpeg?v=1505096833", inventory: 19)
saucer = coffee_shop.items.create(name: "Saucer", description: "This will also break if you drop it. Goes great with cup.", price: 11, image: "https://www.seattlecoffeegear.com/media/catalog/product/cache/1/image/650x/040ec09b1e35df139433887a97daa66f/s/s/ss-kokako.jpg", inventory: 32)
