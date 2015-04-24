Rails.application.routes.draw do
  get 'responders/new', to: 'errors#error_404'
  get 'emergencies/new', to: 'errors#error_404'

  resources :responders, except: [:destroy, :new, :edit], param: :name

  resources :emergencies, except: [:destroy, :new, :edit], param: :code

  match '*a', to: 'errors#error_404', via: :all
end
