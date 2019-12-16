Rails.application.routes.draw do
  mount Annotable::Engine => '/annotable'
end
