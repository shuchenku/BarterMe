BarterMe::Application.routes.draw do
  
  root 'welcome#index'
  
  #loaderio
  get '/loaderio-aebddc794bb8ac95237b9436d82e65c1', :to redirect('/loaderio-aebddc794bb8ac95237b9436d82e65c1.html')

  resources :line_items

  resources :carts, :path => "watchlist"
  
  resources :categories

  resources :offer_forms, only: [:new, :create]
  
  controller :admin do
    get 'admin' => :index
  end
  
  controller :welcome do
    get 'listings' => :all_listings
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
    delete 'logout' => :destroy
  end

  controller :profiles do
    get 'profile' => :profile
    get 'profile/:id' => :profile
  end

  resources :offers do
    get :accept, :on => :member
    get :reject, :on => :member
    post 'offers/new' => :new
  end

  resources :users
  
  
  resources :items do
    collection do
      get 'search'
      get 'my_items'
    end
  end
  
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
