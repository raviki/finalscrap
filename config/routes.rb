Website::Application.routes.draw do
  
  get "about_us/index"
  get "prices/index"
  get '/robots.txt' => 'home#robots'
  root to: "categories#index"
  get "accounts/index" 
  get "password_resets/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "signup" => "customer_managements#new", :as => "signup"
  get "login"  => "sessions#new", :as => "login"
  get "random" => "products#new_parent_map", :as => "random"
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  
  resources :cart_items, :only => [:index, :create, :show, :update, :destroy]

  resources :carts, :only => [:index, :show, :update]
  
  resources :sessions, :only => [:new, :create, :index]

  resources :checkout,  :only => [:new, :create, :index]
  
  resources :order_requests, :only => [:index]
  
  resources :orders, :only => [:index, :show, :create]
  
  resources :customer_managements, :only => [:new, :create, :show, :update]

  resources :customers
  
  resources :product_variants
  
  resources :addresses, :only => [:index, :show, :create]
  
  resources :password_resets
  
  resources :order_requests, :only => [:create]
  
  
  namespace :plus do
    resources :inprogress, :only => [:index]
  end 
  
  resources :terms_and_conditions, :only => [:index]
  
  resources :prices, :only => [:index]
  
  resources :about_us, :only => [:index]
  
  namespace :admin do   
    root to: "fulfillments/orders#index"
    namespace :merchandise do
      resources :products
      resource  :product_variants
      resources :categories 
      get "products/:id/toggle_active" => "products#toggle_active"
      get "products/:id/delete_tool_map" => "products#delete_tool_map"
      get "categories/:id/toggle_active" => "categories#toggle_active"
      put "categories/:id/new_product_map" => "categories#new_product_map"
      get "categories/:id/delete_product_map" => "categories#delete_product_map"    
    end 
    
      
    namespace :customers do
       resources :customers
       resources :customer_groups
       resources :customer_leads
       resources :customer_infos
       get "customers/:id/update_customer_group_id" => "customers#update_customer_group_id"
       get "customers/:id/update_customer_lead_id" => "customers#update_customer_lead_id"
       get "customers/:id/add_customer_info" => "customers#add_customer_info"
       put "customers/:id/add_products2checklist" => "customers#add_products2checklist"   
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
    resources :dbupload, :only => [:index] 
   
  end 
  
  get ":id" => "categories#show"
  resources :categories , :path => '' do
    resources :products, :path=>''  
  end 
  resources :products

end
