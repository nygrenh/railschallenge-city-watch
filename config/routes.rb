Rails.application.routes.draw do
  post 'responders', to: 'responders#create'
end
