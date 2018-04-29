Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated do
      root "items#index", as: :authenticated_root
    end

    unauthenticated do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :items
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
