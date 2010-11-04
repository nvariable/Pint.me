Pintme::Application.routes.draw do
  resources :businesses

  match 'auth/:provider/callback' => 'authorizations#create'
  resources :authorizations
  resources :pints

  get "home/index"
  get "home/dashboard"
  get "home/search"

  get "widgets" => "home#widgets"

  get "logout" => "authorizations#destroy"

  get "redeem" => "pints#redeem"
  post "pints/confirm_redeem"

  match "buy/:screen_name" => "pints#buy"
  match "checkout/confirm" => "pints#confirm", :as => :confirm

  root :to => "home#index"
end
