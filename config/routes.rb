Annotable::Engine.routes.draw do
  resources :users
  resources :organizations do
    resources :reports
  end
end
