Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  namespace :api do
    namespace :v1 do
      resources :quotes
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
