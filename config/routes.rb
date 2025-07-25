Rails.application.routes.draw do
  
  devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions',
  passwords: 'users/passwords'
  }


  resources :scholarships do
    member do
      post :send_matching_notifications
      post :send_deadline_reminders
    end
  end
  
  # Routes pour tester les emails en développement
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :scholarships

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  resources :scholarships, only: [:index, :show] do
    collection do
      get :search
    end
  end
  
  # resources :institutions, only: [:index, :show, :new] do
  #   member do
  #     get :scholarships
  #   end
  # end
  
  # Routes pour utilisateurs connectés
  authenticated :user do
    # Dashboard principal
    
    # Profil étudiant
    # Dans routes.rb
    resource :profile, only: [:show, :edit, :update, :new, :create]    
    # Notifications
    resources :notifications, only: [:index] do
      member do
        patch :mark_as_read
      end
      collection do
        patch :mark_all_as_read
      end
    end
    
     #Routes pour les institutions
     resources :institutions, except: [:index, :show, :new] 
    
  end
  
  # Routes admin
  namespace :admin do
    resources :users, only: [:index, :show]
    resources :dashboard, only: [:index]
    resources :institutions
    
    resources :scholarships
  end
   # Routes institution
  namespace :institution do
    resources :dashboards, only: [:index]    
    resources :scholarships
  end
end
