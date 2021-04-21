Rails.application.routes.draw do
  
  root "photos#index"
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
