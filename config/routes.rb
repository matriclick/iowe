Iowe::Application.routes.draw do
  resources :account_configurations

  resources :payment_profiles

  resources :currencies

  get "dashboard/view" => 'dashboard#view', as: :user_root
  get "dashboard/transactions_tracking" => 'dashboard#transactions_tracking', as: :dashboard_transactions_tracking
  post "dashboard/set_time_zone" => 'dashboard#set_time_zone', as: :set_time_zone_path
  
  resources :transactions
  get 'transaction/:id/mark_as_paid_by_debtor' => 'transactions#mark_as_paid_by_debtor', as: :transaction_mark_as_paid_by_debtor
  get 'transaction/:id/mark_as_paid_by_lender' => 'transactions#mark_as_paid_by_lender', as: :transaction_mark_as_paid_by_lender
  get 'transaction/:id/ask_for_payment' => 'transactions#ask_for_payment', as: :transaction_ask_for_payment
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  
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
