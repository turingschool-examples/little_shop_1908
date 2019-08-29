

Review.destroy_all
Item.destroy_all
Merchant.destroy_all

#merchants
#shops
@bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
@dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
@make_up_shop = Merchant.create(name: "Beauty Mark", address: '124 Lipstick St.', city: 'Golden', state: 'CO', zip: 80600)

#bike_shop items
@tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
@bike = @bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 200, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)
@glove = @bike_shop.items.create(name: "Gloves", description: "You wear them on your hands!", price: 10, image: "http://pngriver.com/wp-content/uploads/2017/11/gloves-free-PNG-transparent-background-images-free-download-clipart-pics-PNGPIX-COM-Gloves-PNG-Transparent-Image-500x337.png", inventory: 30)

#dog_shop items
@pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
@brush = @dog_shop.items.create(name: "Brush", description: "Great for long haired pets", price: 15, image: "https://images-na.ssl-images-amazon.com/images/I/71V8HaHa02L._SL1200_.jpg", inventory: 15)

#make_up_shop items
@lipstick = @make_up_shop.items.create(name: "Pretty Pink", description: "Lipstick for your lips!", price: 20, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDZOukIvE2bTXsP-nKZYWW6jcZnVUFH9KRKoAy3UQTjabG8_efaQ", inventory: 20)
@eye_liner = @make_up_shop.items.create(name: "Wing-tastic", description: "The best eyeliner", price: 15, image: "https://reema-beauty.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/b/l/black.png", inventory: 5)

#tire_reviews
@review_1 = @tire.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 1)
@review_2 = @tire.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 2)
@review_3 = @tire.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 3)
@review_4 = @tire.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 1)
@review_5 = @tire.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 2)
@review_6 = @tire.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 3)

#bike_reviews
@review_7 = @bike.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 1)
@review_8 = @bike.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 4)
@review_9 = @bike.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 5)
@review_10 = @bike.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 1)
@review_11 = @bike.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 1)
@review_12 = @bike.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 1)

#pull_toy_reviews
@review_13 = @pull_toy.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 5)
@review_14 = @pull_toy.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 2)
@review_15 = @pull_toy.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 5)
@review_16 = @pull_toy.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 4)
@review_17 = @pull_toy.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 5)
@review_18 = @pull_toy.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 5)

#brush_reviews
@review_19 = @brush.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 5)
@review_20 = @brush.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 4)
@review_21 = @brush.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 1)
@review_22 = @brush.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 3)
@review_23 = @brush.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 5)
@review_24 = @brush.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 5)

#glove_reviews
@review_25 = @glove.reviews.create(title: 'Review Title 1', content: "Content 1", rating: 3)
@review_26 = @glove.reviews.create(title: 'Review Title 2', content: "Content 2", rating: 3)
@review_27 = @glove.reviews.create(title: 'Review Title 3', content: "Content 3", rating: 3)
@review_28 = @glove.reviews.create(title: 'Review Title 4', content: "Content 4", rating: 2)
@review_29 = @glove.reviews.create(title: 'Review Title 5', content: "Content 5", rating: 2)
@review_30 = @glove.reviews.create(title: 'Review Title 6', content: "Content 6", rating: 2)

#user orders
@order_1 = Order.create!(name: "Mack", address: "123 Happy St", city: "Denver", state: "CO", zip: "80205")
  @item_order_1 = @order_1.item_orders.create!(order: @order_1, item: @bike, quantity: 1, subtotal: @bike.item_subtotal(1))

@order_2 = Order.create(name: "John", address: "123 West St", city: "Golden", state: "CO", zip: "56600")
  @item_order_2 = ItemOrder.create(order: @order_2, item: @tire, quantity: 12, subtotal: @tire.item_subtotal(12))
  @item_order_3 = ItemOrder.create(order: @order_2, item: @brush, quantity: 3, subtotal: @brush.item_subtotal(3))

@order_3 = Order.create(name: "Amber", address: "123 East St", city: "Denver", state: "CO", zip: "80205")
  @item_order_4 = ItemOrder.create(order: @order_3, item: @pull_toy, quantity: 4, subtotal: @pull_toy.item_subtotal(4))
  @item_order_5 = ItemOrder.create(order: @order_3, item: @brush, quantity: 3, subtotal: @brush.item_subtotal(3))
  @item_order_6 = ItemOrder.create(order: @order_3, item: @tire, quantity: 1, subtotal: @tire.item_subtotal(1))
  @item_order_7 = ItemOrder.create(order: @order_3, item: @glove, quantity: 5, subtotal: @glove.item_subtotal(5))

@order_4 = Order.create(name: "Emily", address: "123 North St", city: "Golden", state: "CO", zip: "56601")
  @item_order_8 = ItemOrder.create(order: @order_4, item: @tire, quantity: 1, subtotal: @tire.item_subtotal(1))
  @item_order_9 = ItemOrder.create(order: @order_4, item: @bike, quantity: 1, subtotal: @bike.item_subtotal(1))

@order_5 = Order.create(name: "Adam", address: "123 South St", city: "Chicago", state: "IL", zip: "61704")
  @item_order_10 = ItemOrder.create(order: @order_5, item: @pull_toy, quantity: 5, subtotal: @pull_toy.item_subtotal(5))
  @item_order_11 = ItemOrder.create(order: @order_5, item: @tire, quantity: 2, subtotal: @tire.item_subtotal(2))

@order_6 = Order.create(name: "Matt", address: "123 Road St", city: "Chicago", state: "IL", zip: "61704")
  @item_order_12 = ItemOrder.create(order: @order_6, item: @bike, quantity: 2, subtotal: @bike.item_subtotal(2))
  @item_order_13 = ItemOrder.create(order: @order_6, item: @brush, quantity: 1, subtotal: @brush.item_subtotal(1))

@order_7 = Order.create(name: "Matt", address: "123 Road St", city: "Boston", state: "IL", zip: "61704")
  @item_order_14 = ItemOrder.create(order: @order_7, item: @pull_toy, quantity: 8, subtotal: @pull_toy.item_subtotal(2))
  @item_order_15 = ItemOrder.create(order: @order_7, item: @brush, quantity: 1, subtotal: @brush.item_subtotal(1))
