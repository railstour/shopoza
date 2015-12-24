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

  resources :checkouts, only: [:create, :index, :delete] do
    collection do
      # end point for checking out using VT-Direct
      get "/direct" => "checkouts#direct_form"
      post "/direct" => "checkouts#checkout_direct"

      # end point which veritrans will be redirected to (VT-Web)
      get "/vt/payment/callbacks" => "checkouts#vt_payment_callbacks"
    end
  end
end
