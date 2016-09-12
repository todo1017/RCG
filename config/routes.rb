Rails.application.routes.draw do

  resources :owner_users
  resources :building_occupancies
  resources :user_geographies
  resources :comp_groups
  resources :geographies
  resources :amenity_patios
  resources :amenity_ceilings
  resources :building_unit_amenities
  resources :amenity_concierges
  resources :building_amenities
  resources :building_fee_schedules
  resources :password_resets
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'admin_screens', to: 'owners#index', as: 'admin_screens'
  get 'comparisons', to: 'building_units#comparisons'
  get 'comp_new', to: 'building_units#comp_new'
  get 'comp_edit/:id', to: 'building_units#comp_edit'
  get 'comp_index', to: 'building_units#comp_index'
  get 'geographies/user/:user_id', to: 'user_geographies#index'
  get 'geographies/user/:user_id/new', to: 'user_geographies#new'
  get 'analytics', to: 'building_units#analytics'
  get 'user_assignments', to: 'owner_users#user_assignments'
  get 'user_buildings', to: 'users#user_buildings'
  get 'toggle_dpm_admin', to: 'owner_users#toggle_dpm_admin'
  get 'analyses/data', to: 'analyses#index'
  get 'analyses/update', to: 'analyses#update'
  get 'analyses/update_data', to: 'analyses#update_data'
  get 'analyses/ppsf', to: 'analyses#ppsf'
  get 'analyses/ppsf_filter1', to: 'analyses#ppsf_filter1'
  get 'analyses/ppsf_filter2', to: 'analyses#ppsf_filter2'
  get 'analyses/map', to: 'analyses#map'
  get 'analyses/us_states_data', to: 'analyses#us_states_data'
  get 'analyses/us_county_data', to: 'analyses#us_county_data'

  get 'rent_roll/:building_id', to: 'building_units#rent_roll', as: "rent_roll"

  resources :users do
    member do
      post :toggle_super_admin
      post :toggle_owner_admin
      post :toggle_pm_admin
    end
  end
  resources :sessions
  resources :owners
  resources :buildings
  resources :building_units do
    collection {
      post :import
      post :import_yardi_1
    }
  end
  resources :unit_types

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
