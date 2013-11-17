Website::Application.routes.draw do

  resources :order_requests
  
  root to: "categories#index"
 
  get "product_variants/edit"
  get "product_variants/new"
  resources :product_variants

  get "accounts/index"

  get "checkout/index"
  get "checkout/create"
  resources :addresses

  resources :cart_items
  
  get "customer_infos/edit"
  get "customer_info/edit"
  get "activity_logs/index"
  get "activity_log/index"
  resources :activities

  get "password_resets/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "random" => "products#new_parent_map", :as => "random"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  
  resources :cart_items

  resources :carts

  resources :searches

  resources :vouchers

  resources :orders

  resources :stores

  resources :customer_leads

  resources :customer_groups

  resources :customer_managements

  resources :customers
  
  resources :password_resets

  namespace :users do
    resources :managements
  end
  
  resources :sessions
  
  namespace :admin do
    namespace :merchandise do
      resources :products
      resource  :product_variants
      resources :categories 
      get "products/:id/toggle_active" => "products#toggle_active"
      get "products/:id/new_parent_map" => "product#new_parent_map"
      get "categoties/:id/toggle_active" => "categories#toggle_active"
      put "categoties/:id/new_product_map" => "categories#new_product_map"
      get "categoties/:id/delete_product_map" => "categories#delete_product_map"    
    end 
    
      
    namespace :customers do
       resources :customers
       resources :customer_groups
       resources :customer_leads
       resources :customer_infos
       get "customers/:id/update_customer_group_id" => "customers#update_customer_group_id"
       get "customers/:id/update_customer_lead_id" => "customers#update_customer_lead_id"
       get "customers/:id/add_customer_info" => "customers#add_customer_info"    
    end
    
    namespace :partners do
       resources :stores
       get "stores/:id/toggle_active" => "stores#toggle_active"
       put "stores/:id/update_product_map" => "stores#update_product_map"
       get "stores/:id/delete_product_map" => "stores#delete_product_map"
    end
    
    namespace :deals do
       resources :vouchers
        get "vouchers/:id/toggle_active" => "vouchers#toggle_active"
        get "vouchers/:id/update_customer_group_id" => "vouchers#update_customer_group_id"
    end
    
    namespace :history do
      resources :sales
      resources :activity_logs
    end
    
    namespace :fulfillments do
      resources :orders
       get "orders/:id/create_order" => "orders#create_order"
       get "orders/:id/toggle_active" => "orders#toggle_active"
       get "orders/:id/assign_store" => "orders#assign_store"
    end
    
    get "help" => "help#index"
  end 
  
  get ":id" => "categories#show"
  resources :categories , :path => '' do
    resources :products, :path=>''  
  end
  
  
  resources :products

end
