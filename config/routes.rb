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
    collection do
      get :no_cart
    end
    resources :order_details, only: [:update, :destroy]
  end
end
