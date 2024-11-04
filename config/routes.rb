Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :movies do
      resources :reservations, only: %i[create destroy]
    end
    resources :showtimes # Move this line outside of the movies block
    resources :users
  end  

  devise_for :users

  root 'movies#index'

  resources :movies do
    resources :showtimes do
      resources :reservations, only: %i[create destroy]
    end
  end

  resources :reservations, only: %i[index]
end