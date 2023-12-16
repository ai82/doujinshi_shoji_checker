Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'homes_about'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :create, :update]
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy]
  #get 'users/:id' => 'books#index', as: 'user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
