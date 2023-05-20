Rails.application.routes.draw do
  root "users#index"

  get "/users", to: "users#index"
end
