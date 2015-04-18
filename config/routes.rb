Rails.application.routes.draw do
  post 'responders', to: 'responders#create'
  post 'emergencies', to: 'emergencies#create'
end
