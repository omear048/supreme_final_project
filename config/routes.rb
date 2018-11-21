Rails.application.routes.draw do
  

  get 'account_details/orders'

  match '/account_details', to: 'account_details#homepage', via: 'get'
  match 'account_details/address/new',  to: 'account_details#new_address', via: 'get', as: 'new_address'
  match 'account_details/address/new',  to: 'account_details#create', via: 'post'


  match 'account_details/address/edit', to: 'account_details#edit_address', via: 'get', as:  'edit_address'
  match 'account_details/address/edit', to: 'account_details#update', via: 'post'




  resource :cart
  resource :charges #Provides us with all the standard routes for Stripe 


  get 'sessions/new'

  match '/products/selling', to: 'products#selling', via: 'get', as: 'selling_product'
  match '/products/selling/:product_id', to: 'products#destroy', via: 'delete', as: 'delete_listed_product'
  match '/products/selling/:product_id', to: 'products#edit', via: 'get', as: 'edit_listed_product'
  match '/products/selling/:product_id', to: 'products#update', via: 'post', as: 'update_listed_product'

  match '/charges/new', to: 'products#purchase', via: 'post', as: 'products_buy'


  match '/products_users/:product_id', to:'products_users#destroy', via: 'delete', as: 'delete_products_users'
  match '/products_users',      to:'products_users#create',     via: 'post'

  match '/users_cart',    to: 'products_users#cart',  via: 'get'
  match '/users_cart/checkout', to: 'products_users#checkout', via: 'get', as: 'user_checkout'

  resources :products
  root 'static_pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/help',      to:'static_pages#help',      via: 'get'
  #match '/shopping',  to:'products#shopping',      via: 'get'
  match '/selling',   to:'products#selling',       via: 'get'
  match '/sold',      to:'products#sold',          via: 'get'
end


#products_users_path(item.product_id)