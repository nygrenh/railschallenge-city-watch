Rails.application.routes.draw do
  post 'responders', to: 'responders#create'
  patch 'responders/:name', to: 'responders#update'
  post 'emergencies', to: 'emergencies#create'
  get 'emergencies', to: 'emergencies#index'
  patch 'emergencies', to: 'emergencies#index'
  get 'emergencies/:code', to: 'emergencies#show'
end
