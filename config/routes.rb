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

  concern :active do
    post 'toggle_active', on: :member
  end

  concern :order do
    post 'move_up', on: :member
    post 'move_down', on: :member
  end

  resources :topic_groups, concerns: [:active, :order] do
    resources :topics
  end
  resources :topics, concerns: [:active, :order] do
    resources :categories
  end
  resources :categories, concerns: [:active, :order]
  resources :values, concerns: :active, only: [:index, :show, :edit, :update]
  resources :partners, concerns: :active

  resources :events
  resources :virtual_contexts
  resources :crash_reports, only: [:index, :show, :destroy]

  resources :miners do
    resources :miner_scrapers, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :scrapers, concerns: [:active] do
    resources :partitions
    post :test, on: :member
  end
  resources :partitions, concerns: :order do
    resources :extractors
    resources :texts, controller: 'extractors', type: 'Text'
    resources :attribute_values, controller: 'extractors', type: 'AttributeValue'
    resources :attachments, controller: 'extractors', type: 'Attachment'
    resources :has_manies, controller: 'extractors', type: 'HasMany'
    resources :constant_values, controller: 'extractors', type: 'ConstantValue'
  end
  resources :extractors do
    resources :partitions
    post :test, on: :member
  end

end
