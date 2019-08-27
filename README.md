# Little Shop
BE Mod 2 Week 2/3 Pair Project

## Background and Description

"Little Shop" is a fictitious e-commerce platform where users can place items into a shopping cart and 'check out' to create Orders in the database.

Students will be put into pairs to complete the project.

## Learning Goals

### Rails
* Describe use cases for a model that inherits from ApplicationRecord vs. a PORO
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Make use of flash messages
* Use Inheritance from ApplicationController or a student created controller to store methods that will be used in multiple controllers
* Use POROs to logically organize code for objects not stored in the database

### ActiveRecord
* Use built-in ActiveRecord methods to:
* create queries that calculate, select, filter, and order data from a single table

### Databases
* Describe Database Relationships, including the following terms:
* Many to Many
* Join Table

### Testing and Debugging
* Write feature tests utilizing
* Sad Path Testing
* Write model tests with RSpec including validations, and class and instance methods

### Web Applications
* Explain how Cookies/Sessions are used to create and maintain application state
* Describe and implement ReSTful routing
* Identify use cases for, and implement non-ReSTful routes
* Identify the different components of URLs(protocol, domain, path, query params)
## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- all controller and model code must be tested via feature tests and model tests, respectively
- must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool
- must include a README to describe their project

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors first

## User Stories

```
[ ] done

User Story 1, Deploy your application to Heroku

As a visitor or user of the site
I will perform all user stories
By visiting the application on Heroku.
Localhost is fine for development, but
the application must be hosted on Heroku.
```

---

## Navigation
Users should be able to navigate the application using only links/buttons.

```
[ ] done

User Story 2, Item Link Navigation

As a visitor
With the exception of an item's show page,
Anywhere I see an item name on the site,
I can click on the item name to go to that item's show page.
```

```
[ ] done

User Story 3, Merchant Link Navigation

As a Visitor
With the exception of an merchant's show page,
Anywhere I see an merchant name on the site,
I can click on the merchant name to go to that merchant's show page.
```

---

## Item Reviews
Users will be able to review items

```
[ ] done

User Story 4, Reviews on Item Show Page

As a visitor,
When I visit an item's show page,
I see a list of reviews for that item
Each review will have:
- title
- content of the review
- rating (1 to 5)
```

```
[ ] done

User Story 5, Review Creation

As a visitor,
When I visit an item's show page
I see a link to add a new review for this item.
When I click on this link, I am taken to a new review path
On this new page, I see a form where I must enter:
- a review title
- a numeric rating that can only be a number from 1 to 5
- some text for the review itself
When the form is submitted, I should return to that item's
show page and I should see my review text.
```

```
[ ] done

User Story 6, Review Creation, cont.

As a visitor,
When I fail to fully complete the new review form, but still try to submit the form
I see a flash message indicating that I need to complete the form in order to submit a review
```

```
[ ] done

User Story 7, Review Statistics

As a visitor
When I visit an item's show page,
I see an area on the page for statistics about reviews:
- the top three reviews for this item (title and rating only)
- the bottom three reviews for this item  (title and rating only)
- the average rating of all reviews for this item
```

```
[ ] done

User Story 8, Edit a Review

As a visitor,
When I visit an item's show page
I see a link to edit the review next to each review.
When I click on this link, I am taken to an edit review path
On this new page, I see a form that includes:
- title
- numeric rating
- text of the review itself
I can update any of these fields and submit the form.
When the form is submitted, I should return to that item's
show page and I should see my updated review
```

```
[ ] done

User Story 9, Delete a review

As a visitor,
When I visit an item's show page,
I see a link next to each review to delete the review.
When I delete a review I am returned to the item's show page
Then I should no longer see that review.
```

---

## Cart & Order
Users will be able to add items to a cart, and check out to create orders in the database.

```
[ ] done

User Story 10, Cart Indicator

As a visitor
I see a cart indicator in my navigation bar
The cart indicator shows a count of items in my cart
I can see this cart indicator from any page in the application
```

```
[ ] done

User Story 11, Cart Creation

As a visitor
When I visit an item's show page from the items index
I see a link or button to add this item to my cart
And I click this link or button
I am returned to the item index page
I see a flash message indicating the item has been added to my cart
The cart indicator in the navigation bar increments my cart count
```

```
[ ] done

User Story 12, Cart Show Page

As a visitor
When I have added items to my cart
And I visit my cart ("/cart")
I see all items I've added to my cart
Each item in my cart shows the following information:
- the name of the item
- the item image
- the merchant I'm buying this item from
- the price of the item
- my desired quantity of the item
- a subtotal (price multiplied by quantity)
I also see a grand total of what everything in my cart will cost
```

```
[ ] done

User Story 13, Empty Cart Show Page

As a visitor
When I add NO items to my cart yet
And I visit my cart ("/cart")
I see a message that my cart is empty
I do NOT see the link to empty my cart
```

```
[ ] done

User Story 14, Emptying Cart

As a visitor
When I have items in my cart
And I visit my cart ("/cart")
And I click the link to empty my cart
Then I am returned to my cart
All items have been completely removed from my cart
The navigation bar shows 0 items in my cart
```

```
[ ] done

User Story 15, Removing Item from Cart

As a visitor
When I have items in my cart
And I visit my cart
Next to each item in my cart
I see a button or link to remove that item from my cart
- clicking this button will remove the item but not other items
```

```
[ ] done

User Story 16, Adding Item Quantity to Cart

As a visitor
When I have items in my cart
And I visit my cart
Next to each item in my cart
I see a button or link to increment the count of items I want to purchase
I cannot increment the count beyond the item's inventory size
```

```
[ ] done

User Story 17, Decreasing Item Quantity from Cart

As a visitor
When I have items in my cart
And I visit my cart
Next to each item in my cart
I see a button or link to decrement the count of items I want to purchase
If I decrement the count to 0 the item is immediately removed from my cart
```

```
[ ] done

User Story 18, Link to Checkout

As a visitor
When I have items in my cart
And I visit my cart
I see a button or link to Checkout
When I click that button, I am taken to the new order page
```

```
[ ] done

User Story 19, New Order Page

As a visitor
When I check out from my cart
On the new order page I see the details of my cart:
- the name of the item
- the merchant I'm buying this item from
- the price of the item
- my desired quantity of the item
- a subtotal (price multiplied by quantity)
- a grand total of what everything in my cart will cost
I also see a form to where I must enter my shipping information for the order:
- name
- address
- city
- state
- zip
I also see a button to 'Create Order'
```

```
[ ] done

User Story 20, Order Creation

As a visitor
When I fill out all information on the new order page
And click on 'Create Order'
An order is created and saved in the database
And I am redirected to that order's show page with the following information:
- My name and address (shipping information)
- Details of the order:
- the name of the item
- the merchant I'm buying this item from
- the price of the item
- my desired quantity of the item
- a subtotal (price multiplied by quantity)
- a grand total of what everything in my cart will cost
- the date when the order was created
```

```
[ ] done

User Story 21, Order Creation, cont.

As a visitor
From the order creation page
When I click 'Create Order' without completing the shipping address form
I see a flash message indicating that I need to complete the form for successful order creation
```

---

## Merchant
Visitors will have additional constraints when manipulating merchant data in the database.

```
[ ] done

User Story 22, Merchants with Orders cannot be Deleted

As a visitor
If a merchant has items that have been ordered
I can not delete that merchant
Either:
- there is no button visible for me to delete the merchant
- if I click on the delete button, I see a flash message indicating that the merchant can not be deleted.
```

```
[ ] done

User Story 23, Merchants with no Orders can be Deleted

As a visitor
If a merchant has items that have not been ordered
I can delete that merchant.
When that merchant is deleted
Then all of their items are deleted as well.
```

```
[ ] done

User Story 24, Flash Messages for Merchant Create and Update

As a visitor
When I am updating or creating a new merchant
If I try to submit the form with incomplete information
I see a flash message indicating which field(s) I am missing
```

```
[ ] done

User Story 25, Merchant Statistics

As a visitor
When I visit a merchant's show page
I see statistics for that merchant, including:
- count of items for that merchant
- average price of that merchant's items
- Distinct cities where my items have been ordered
```

---

## Item
Visitors will have additional constraints when manipulating item data in the database.

```
[ ] done

User Story 26, Deleting Items Deletes its Reviews

As a visitor
When I delete an item
All reviews associated with that item are also deleted
```

```
[ ] done

User Story 27, Items with Orders Cannot be Deleted

As a visitor
If an item has been ordered
I can not delete that item
Either:
- there is no button visible for me to delete the item
- if I click on the delete button, I see a flash message indicating that the item can not be deleted.
```

```
[ ] done

User Story 28, Flash Message for Item Create and Update

As a visitor
When I am updating or creating a new item
If I try to submit the form with incomplete information
I see a flash message indicating which field(s) I am missing
```

---

## Extensions

```
[ ] done

User Story 29, Sortable Reviews

As a visitor,
When I visit an item's show page to see their reviews,
I see additional links to sort their reviews in the following ways:
- sort reviews by highest rating, then by descending date
- sort reviews by lowest rating, then by ascending date
```

```
[ ] done

User Story 30, More Merchant Statistics

As a visitor,
When I visit an merchant's show page
I see the top 3 highest rated items for that merchant (by average rating)
```

```
[ ] done

User Story 31, Order Update and Delete

As a visitor
When I check out
I see a flash message with a randomly generated, 10 digit verification code associated with that order

I can use that verification code to search for an order through the nav bar.
If an order is found, I am redirected to a verified order page ('/verified_order')
On that verified order page, I can:
- click a link to delete the order
- update the shipping address for an order
- remove items from the order
```

## Rubric


| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** | **Styling, UI/UX** |
| --- | --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including all sad paths and edge cases, and some extension work completed | Students implement strategies not discussed in class to effectively organize code using POROs and adhere to MVC | Highly effective and efficient use of ActiveRecord beyond what we've taught in class. Even `.each` calls will not cause additional database lookups. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students utilize `before :each` blocks. 100% coverage for features and models | Extremely well styled and purposeful layout. Excellent color scheme and font usage. All other rubric categories score 3 or 4. |
| **3: Passing** | Students complete all User Stories. No more than 2 Stories fail to correctly implement sad path and edge case functionality. | Students use the principles of MVC and POROs vs. Models to effectively organize code. Students can defend any of their design decisions. | ActiveRecord is used in a clear and effective way to read/write data using no Ruby to process data. | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. | Purposeful styling pattern and layout using `application.html.erb`. Links or buttons to reach all areas of the site. |
| **2: Passing with Concerns** | Students complete all but 1 - 3 User Stories | Students utilize MVC and POROs to organize code, but cannot defend some of their design decisions. | Ruby is used to process data that could use ActiveRecord instead. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. | Styling is poor or incomplete. Incomplete navigation for some routes, i.e. users must manually type URLs. |
| **1: Failing** | Students fail to complete 4 or more User Stories | Students do not effectively organize code using MVC and/or POROs | Ruby is used to process data more often than ActiveRecord | Below 90% coverage for either features or models. | No styling or no buttons or links to navigate the site. |
