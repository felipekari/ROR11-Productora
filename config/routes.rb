Rails.application.routes.draw do
  resources :groups do
    resources :concerts
    resources :crews
  end
  root "groups#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
