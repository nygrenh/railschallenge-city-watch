Rails.application.routes.draw do
  post 'responders', to: 'responders#create'
  patch 'responders/:name', to: 'responders#update'
  get 'responders', to: 'responders#index'
  get 'responders/:name', to: 'responders#show'

  post 'emergencies', to: 'emergencies#create'
  get 'emergencies', to: 'emergencies#index'
  patch 'emergencies', to: 'emergencies#index'
  get 'emergencies/:code', to: 'emergencies#show'
  patch 'emergencies/:code', to: 'emergencies#update'
end
