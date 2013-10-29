Website::Application.routes.draw do

  root to: "welcome#index"
  
  get "product_variants/edit"
  get "product_variants/new"
  resources :product_variants

  get "customer_infos/edit"
  get "customer_info/edit"
  get "activity_logs/index"
  get "activity_log/index"
  resources :activities

  get "password_resets/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  
  resources :cart_items

  resources :carts

  resources :searches

  resources :vouchers

  resources :orders

  resources :stores

  resources :categories

  resources :products

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
       get "customers/:id/add_to_wishlist" => "customers#add_to_wishlist"
       get "customers/:id/add_customer_info" => "customers#add_customer_info"    
    end
    
    namespace :partners do
       resources :stores
       get "stores/:id/toggle_active" => "stores#toggle_active"
       get "stores/:id/update_product_map" => "stores#update_product_map"
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

end
