Rails.application.routes.draw do
  devise_for :users

  resources :wikis do
  end
  resources :charges, only: [:new, :create]
  get 'sessions/create'

  get 'sessions/destroy'

  
  get 'welcome/index'
  

  get 'welcome/about'
  root 'welcome#index'
end
