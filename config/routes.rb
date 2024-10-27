Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :movies  # This will create paths like admin_movies_path
    resources :showtimes  # This will create paths like admin_showtimes_path
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