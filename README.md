# Little Shop
BE Mod 2 Week 2/3 Pair Project

## About Little Shop

Little Shop is a fictitious online e-commerce platform built with Ruby on Rails. Functionality includes merchants, items, reviews, orders, and a cart. Users can create, read, update, and destroy items, reviews, merchants, and orders. Cart functionality uses sessions to track items to be ordered across the platform. Database interaction was handled with ActiveRecord/SQL queries, and address verification uses the MainStreet gem. Sad paths/edge cases are handled primarily through displaying flash messages to the user specifying what information is missing to complete their request or why their request is invalid. Model and feature testing was implemented with RSpec/Capybara, and SimpleCov shows 100% testing coverage.

Heroku: https://e-s-pug-n.herokuapp.com

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

