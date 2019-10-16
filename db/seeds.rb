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
suite_deal= Merchant.create(name: "Suite Deal Home Goods", address: '1280 Park Ave', city: 'Denver', state: 'CO', zip: "80202")
knit_wit = Merchant.create(name: "Knit Wit", address: '123 Main St.', city: 'Denver', state: 'CO', zip: "80218")
a_latte_fun = Merchant.create(name: "A Latte Fun", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: "80210")
pawty_city = Merchant.create(name: "Paw-ty City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")

#suite_deal items
four_pillows = suite_deal.items.create(name: "Fall Pillow Set (4-Pack)", description: "Four fall pillows that will leaf your house feeling festive.", price: 17.00, image: "https://i.imgur.com/lLiFbjC.jpg", inventory: 22)
blessed_pillows = suite_deal.items.create(name: "Blessed Pillow Set (3-Pack)", description: "These comfy pillows will have you feeling #blessed", price: 30.00, image: "https://i.imgur.com/Q8b4Qob.jpg", inventory: 8)
fall_blankets = suite_deal.items.create(name: "Cozy Blankets", description: "Wrap up in these colorful fall blankets!", price: 15.75, image: "https://i.imgur.com/LmmnJSM.jpg", inventory: 12)
fall_candles = suite_deal.items.create(name: "Candle Set", description: "Have your home smelling like pumpkin spice without setting foot in the kitchen!", price: 16.00, image: "https://i.imgur.com/r4bD0wP.jpg", inventory: 3)

#knit_wit items
beanies = knit_wit.items.create(name: "Beanies (2-Pack)", description: "You are ready to brave the cold with these warm beanies.", price: 24.00, image: "https://i.imgur.com/NpRoKD7.jpg", inventory: 6)
mittens = knit_wit.items.create(name: "Hedgehog Mittens", description: "Mittens that keep your hands warm and look cute too!", price: 30.50, image: "https://i.imgur.com/UC1VvhE.jpg", inventory: 17)
scarf = knit_wit.items.create(name: "Scarf", description: "You are ready for fall with this fashionable scarf.", price: 16.99, image: "https://i.imgur.com/zMmclXc.jpg", inventory: 2)

#pawty_city items
hot_dog = pawty_city.items.create(name: "Hot Dog Costume", description: "Purfect for your small to medium sized dog.", price: 17.00, image: "https://i.imgur.com/UQ8MPHd.jpg", inventory: 5)
banana = pawty_city.items.create(name: "Banana Costume", description: "Don't let this costume slip by you!", price: 13.50, image: "https://i.imgur.com/Eg0lBXd.jpg", inventory: 7)
shark = pawty_city.items.create(name: "Baby Shark Costume", description: "Baby shark, doo doo doo doo doo doo doo... ", price: 23.75, image: "https://i.imgur.com/gzRbKT2.jpg", inventory: 2)
harry_potter = pawty_city.items.create(name: "Harry Potter Costume", description: "Look who got into Hogwarts.", price: 16.00, image: "https://i.imgur.com/GC4ppbA.jpg", inventory: 13)

#a_latte_fun items
chai_latte = a_latte_fun.items.create(name: "Chai Latte", description: "So yummy!", price: 4.50, image: "https://i.imgur.com/G5powzX.jpg", inventory: 10)
pumpkin_loaf = a_latte_fun.items.create(name: "Pumpkin Spice Loaf", description: "Warm and tasty!", price: 5.00, image: "https://i.imgur.com/Q3dEKCn.jpg", inventory: 7)
apple_strudel = a_latte_fun.items.create(name: "Apple Strudel", description: "Just as good as grandma's.", price: 6.00, image: "https://i.imgur.com/GJA1T0e.jpg", inventory: 3)
hot_coco = a_latte_fun.items.create(name: "Hot Chocolate", description: "Delicious dark hot chocolate topped with whip cream.", price: 3.50, image: "https://i.imgur.com/cDI4mCQ.jpg", active?:false, inventory: 12)

#hot_dog costume reviews
review_1 = hot_dog.reviews.create(title: "Worst costume!", content: "NEVER buy this costume.", rating: 1)
review_2 = hot_dog.reviews.create(title: "Awesome costume!", content: "This was a great costume! Would buy again.", rating: 5)
review_3 = hot_dog.reviews.create(title: "Meh", content: "I probably wouldn't buy this again.", rating: 3)
review_4 = hot_dog.reviews.create(title: "Really Good Costume", content: "Can't wait to order more. I gave it a 4 because the order took long to process.", rating: 4)
review_5 = hot_dog.reviews.create(title: "Disappointed", content: "Super disappointed in this costume. It broke after one use! Don't buy.", rating: 2)
review_6 = hot_dog.reviews.create(title: "Best costume EVER!", content: "I'm ordering this costume for everyone I know with a dog. That's how much I loved it!", rating: 5)
