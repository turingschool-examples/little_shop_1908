Rails.application.routes.draw do
  # merchants routes
  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id', to: 'merchants#show'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'
  # reviews routes
  get '/items/:item_id/review', to: 'reviews#new'
  post '/items/:item_id', to: 'reviews#create'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'
  # items routes
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
  delete '/items/:id', to: 'items#destroy'

  # cart routes
  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#create'
  patch '/cart/remove_item/:item_id', to: 'cart#remove_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'

  # order routes
  get '/orders/new', to: "orders#new"
  post '/orders', to: "orders#create"
  get "/orders/:id", to: "orders#show"
end
