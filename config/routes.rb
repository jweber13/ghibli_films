Rails.application.routes.draw do
  root 'films#index'
  resources :films, only: %i[index show]
end
