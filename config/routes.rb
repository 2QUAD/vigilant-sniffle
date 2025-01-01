# config/routes.rb
Rails.application.routes.draw do
  get "passwords/new"
  post "passwords", to: "passwords#create"
  post "ssh_keys/upload", to: "ssh_keys#upload"
  get "ssh_keys/new", to: "ssh_keys#new"
  get "ssh_keys", to: "ssh_keys#index"
  get "ssh_keys/:id", to: "ssh_keys#show"
  get "ssh_keys/:id/edit", to: "ssh_keys#edit"
end
