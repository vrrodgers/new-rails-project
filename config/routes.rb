Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  get 'sessions/create'

  get 'sessions/destroy'

  
  get 'welcome/index'
  

  get 'welcome/about'
  root 'welcome#index'
end
