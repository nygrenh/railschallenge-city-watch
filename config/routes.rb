Rails.application.routes.draw do
  resources :responders, except: [:destroy, :new, :edit], param: :name

  resources :emergencies, except: [:destroy, :new, :edit], param: :code

  # Render a 404 page for all unmatched requests even when not in production
  match '*a', to: 'application#error_404', via: :all
end
