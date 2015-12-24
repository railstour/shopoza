Rails.application.routes.draw do
  devise_for :users, controllers: {
  	confirmations: "users/confirmations",
  	omniauth: "users/omniauth",
  	passwords: "users/passwords",
  	registrations: "users/registrations",
  	sessions: "users/sessions",
  	unlocks: "users/unlocks"
  }

  root to: "home#index"

  resources :orders, only: [:index, :show, :create] do
  end

  resources :carts, only:[:index, :update, :create] do
    collection do
      resources :cart_details, only: [:update, :destroy]
    end
  end
end
