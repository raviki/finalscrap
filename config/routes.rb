Website::Application.routes.draw do
  
  resources :cart_items

  resources :carts

  get "password_resets/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
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

  namespace :users do
    resources :managements
  end
  
  resources :sessions
  
  namespace :admin do
    namespace :merchandise do
      resources :products 
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
       get "customers/:id/update_customer_group_id" => "customers#update_customer_group_id"
       get "customers/:id/update_customer_lead_id" => "customers#update_customer_lead_id"
       get "customers/:id/add_to_wishlist" => "customers#add_to_wishlist"
       
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
    end
    
    namespace :fulfillments do
      resources :orders
       get "orders/:id/create_order" => "orders#create_order"
       get "orders/:id/toggle_active" => "orders#toggle_active"
       get "orders/:id/assign_store" => "orders#assign_store"
    end
    
    get "help" => "help#index"
  end 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
