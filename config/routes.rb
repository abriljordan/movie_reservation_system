Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :showtimes
    resources :movies
  end


  devise_for :users

  authenticated :user do
    root to: 'movies#index', as: :authenticated_root
  end
  
  unauthenticated do
    root to: 'pages#home'
  end

  resources :movies do
    resources :showtimes do
      resources :reservations, only: %i[create destroy]
    end
  end

  resources :reservations, only: %i[index]
end