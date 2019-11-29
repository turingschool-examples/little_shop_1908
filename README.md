# Little Shop

## Introduction

"Little Shop" is a fictitious e-commerce platform where users can place items into a shopping cart and 'check out' to create Orders in the database.

## Contributors
Little Shop was written by Kelly Sandeson and Leiya Kenney as a Back End Mod 2 project at Turing School of Software and Design


## Version Info
- Ruby 2.4.1
- Rails 5.2.0

## Local Setup
```
$ git clone
```

```
$ bundle install
```

```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

## To Run the Test Suite:
```ruby
$ bundle exec rspec
```

## Tech Stack
* Ruby on Rails
* Production hosted on Heroku: https://dashboard.heroku.com/apps/minishop-kellyleiya

## Project Overview
- User can use nav bar to view all merchants, all items and cart as well as total count of items in cart, has a non-functional search bar
- Home page is the merchant index
- User can view all items on the site, or only those specific to a merchant through the merchant page
- For items, merchants and reviews, a visitor has the ability to create new, edit and delete. You can't delete items if they are in a cart, or merchants if they have orders
- Items can be added to and removed from cart. And quantity can be changed by one before checkout by using the add/remove buttons
- User can click checkout and provide shipping information to create a new order
- Users can add reviews to items and sort them by highest/lowest reviews
- Item and merchants display statistics about reviews (avg. review, etc.) and items carried by merchant (avg. review, etc.)
- Forms can't be submitted unless all fields are filled

