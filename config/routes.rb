Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  get "/items", to: "items#index", as: :items
  get "/items/:id", to: "items#show", as: :item
  get "/items/:id/reviews/new", to: "reviews#new", as: :new_review
  post "/items/:id", to: "reviews#create"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  delete "/items/:id/reviews", to: "reviews#destroy", as: :delete_review
  get "/items/:id/reviews/format/edit", to: "reviews#edit", as: :edit_review
  patch "/items/:id", to: "reviews#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/cart", to: "cart#show"
  post "/cart/:id", to: "cart#add_item"
  patch "/cart/empty", to: "cart#empty", as: :empty_cart
  patch "/cart/:id", to: "cart#update", as: :update_cart
  patch '/cart/:id/add', to: 'cart#me_add', as: :me_add
end
