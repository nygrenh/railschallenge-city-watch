Rails.application.routes.draw do
  # Without the constraint, when doing a get request to '/responders/new' it will match
  # GET /responders/:name(.:format) which is not what we want because the specification
  # requires that request to render an error page.
  resources :responders, except: [:destroy, :new, :edit], param: :name,
                         constraints: ->(request) { request.params[:name] != 'new' }

  resources :emergencies, except: [:destroy, :new, :edit], param: :code,
                          constraints: ->(request) { request.params[:code] != 'new' }

  # Render a 404 page for all unmatched requests even when not in production
  match '*a', to: 'errors#error_404', via: :all
end
