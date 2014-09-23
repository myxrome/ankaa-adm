Ankaa::Application.routes.draw do
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

  devise_for :users, skip: [:sessions]
  devise_scope :user do
    get '/hi', to: 'devise/sessions#new', as: :new_user_session
    post '/hi', to: 'devise/sessions#create', as: :user_session
    delete '/bb', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root to: 'topics#index'

  concern :toggleable do
    post 'toggle_active', on: :member
  end

  concern :orderable do
    post 'move_up', on: :member
    post 'move_down', on: :member
  end

  resources :topics, concerns: [:toggleable, :orderable] do
    resources :categories
  end
  resources :categories, concerns: [:toggleable, :orderable] do
    resources :values do
      post :create_from_url, :on => :collection
      get :autocomplete_description_caption, :on => :collection
    end
  end
  resources :values, concerns: :toggleable do
    post :create_from_url, :on => :collection
    get :autocomplete_description_caption, :on => :collection

    get :auto, on: :collection

  end
  resources :partners, concerns: :toggleable

  resources :events
  resources :virtual_contexts

  resources :miners do
    resources :miner_scrapers, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :scrapers do
    resources :mappings
  end
  resources :mappings, concerns: :orderable do
    resources :transformers
    resources :texts, controller: 'transformers', type: 'Text'
    resources :attachments, controller: 'transformers', type: 'Attachment'
    resources :orders, controller: 'transformers', type: 'Order'
    resources :has_manies, controller: 'transformers', type: 'HasMany'
  end
  resources :transformers do
    resources :mappings
  end

end
