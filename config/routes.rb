Runconf::Application.routes.draw do
  resources :races do
    resource :attendance, only: [:create, :destroy]
  end
  resources :users, only: :show
  resource :account, only: :show
  resource :session, only: [:create, :destroy]
  
  match "/auth/github/callback" => "sessions#create"
  
  root :to => "races#index"
end
