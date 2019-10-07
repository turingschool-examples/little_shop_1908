# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Merchant.destroy_all
# Item.destroy_all
# Review.destroy_all

merchants = Merchant.create([
  {
    name: 'Florist Gump',
    address: '1523 N Main Street',
    city: 'Plaintree',
    state: 'MN',
    zip: 49155
  },
  {
    name: 'Back to the Fuschia',
    address: '943 Burberry Drive',
    city: 'Kirksville',
    state: 'NC',
    zip: 30846
  },
  {
    name: 'Pine Oakio',
    address: '12 Montgomery Lane',
    city: 'Alden',
    state: 'AL',
    zip: 61350
  }
])
items = Item.create([
  {
    name: 'Plumeria Plant',
    description: 'The plumeria plant, also known as the "Scent of Hawaii", is like no other plant. It has electric hues of yellow, pink, and white blossoms that bloom from April until November. It also has a slender, geometric shape, and soft foliage that will branch and produce up to 60 flowers and over 100 blossoms each year.',
    price: 93.20,
    image: 'https://images.pexels.com/photos/63609/plumeria-flower-frangipani-plant-63609.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    active?: true,
    inventory: 14,
    merchant_id: merchants[0].id
  },
  {
    name: 'Dahlia Bulbs - Contraste Variety',
    description: 'A timeless dahlia favorite, introduced almost 60 years ago and still going strong. The big blooms measure up to eight inches across and have striking two-tone petals that are deep burgundy and purple with brilliant white tips.',
    price: 15.40,
    image: 'https://images.pexels.com/photos/910645/pexels-photo-910645.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    active?: true,
    inventory: 32,
    merchant_id: merchants[0].id
  },
  {
    name: 'Clementine Rose Bush',
    description: 'This rose bush grows long, pointed buds that open to classically shaped, four-inch blooms that have an artistic feel to their color - a rich apricot-blush, over-layed with copper tones toward the edge of the petals. The striking blooms are plentifully produced against bright-green, glossy leaves.',
    price: 45.63,
    image: 'https://images.pexels.com/photos/53007/rose-rose-family-rosaceae-composites-53007.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    active?: false,
    inventory: 8,
    merchant_id: merchants[0].id
  },
  {
    name: 'Pink Tropical Hibiscus Tree',
    description: 'Adding a tropical feel to your garden or landscape has never been easier. The pink tropical hibiscus tree is a low-maintenance dwarf tree, reaching only 6-8 feet in height. Its breathtaking blooms occur year-round',
    price: 108.65,
    image: 'https://images.pexels.com/photos/244796/pexels-photo-244796.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    active?: true,
    inventory: 6,
    merchant_id: merchants[2].id
  },
  {
    name: 'Arbequina Olive Tree',
    description: "It's the most versatile variety on the market: The Arbequina Olive Tree. Not only does it produce table olives, but it's also used to make highly-valued olive oil. And this tree offers evergreen beauty and fragrant spring blooms to go along with its succulent fruit.",
    price: 84.99,
    image: 'https://images.pexels.com/photos/1047312/pexels-photo-1047312.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    active?: false,
    inventory: 4,
    merchant_id: merchants[2].id
  },
])
items[0].reviews.create(
  title: "Beautiful!",
  content: "The most beautiful plant I've ever grown!",
  rating: 5
)
items[0].reviews.create(
  title: "Meh!",
  content: "Does not survive snowy weather.",
  rating: 2
)
