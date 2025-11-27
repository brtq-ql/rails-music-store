Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # ...
  root "products#index"
    resources :products do
    resources :subscribers, only: [ :create, :destroy ]
  end
  resource :unsubscribe, only: [ :show ]
end
