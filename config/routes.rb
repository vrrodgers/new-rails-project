Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/mywikis' => 'wikis#mywiki'
  devise_for :users

  resources :wikis do
    resources :collaborators, only: [:new, :create, :edit, :destroy]
  end
  resources :charges, only: [:new, :create]
  resources :users
   match "users/:id/downgrade" => "users#downgrade", :as => "downgrade_user", via: [:get, :post]
  
   get 'sessions/create'

  get 'sessions/destroy'

  
  get 'welcome/index'
  

  get 'welcome/about'
  root 'welcome#index'
end
