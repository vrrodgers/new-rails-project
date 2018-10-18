Rails.application.routes.draw do

  #get 'sessions/create'

  #get 'sessions/destroy'

  devise_for :users
  get 'welcome/index'
  

  get 'welcome/about'
  root to: 'welcome#index'
end
