# config/routes.rb
Rails.application.routes.draw do
  get "passwords/new"
  post "passwords", to: "passwords#create"

  root "passwords#new"
end
