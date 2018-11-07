Rails.application.routes.draw do
  

  resource :cart


  get 'sessions/new'

  match '/products_users/:product_id', to:'products_users#destroy', via: 'delete', as: 'delete_products_users'
  match '/products_users',      to:'products_users#create',     via: 'post'

  match '/users_cart',    to: 'products_users#cart',  via: 'get'

  resources :products
  root 'static_pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/help',      to:'static_pages#help',      via: 'get'
  match '/shopping',  to:'products#shopping',      via: 'get'
  match '/selling',   to:'products#selling',       via: 'get'
end


#products_users_path(item.product_id)