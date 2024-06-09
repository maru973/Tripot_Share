Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    invitations: 'users/invitations',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  get "up" => "rails/health#show", as: :rails_health_check

  root "staticpages#top"

  get '/privacy_policy', to: 'staticpages#privacy_policy'
  get '/terms_of_service', to: 'staticpages#terms_of_service'
  get '/contact_us', to: 'staticpages#contact_us'
  
  
  resources :plans do
    resources :spots, only: %i[create destroy], shallow: true
    resources :spot_points, only: %i[index update edit], shallow: true
    resources :courses, only: %i[new create update edit show], shallow: true
  
    member do
      get 'new_spots'
      post 'invitation'
      get 'invitation/accept/:invitation_token', to: 'plans#accept', as: 'accept'
    end
  end

  resource :mypage, only: %i[show edit destroy update]
  get 'myplans', to: 'mypages#myplans'
  get 'mycourses', to: 'mypages#mycourses'

  resources :courses, only: %i[show] do
    member do
      post :create_position
      patch :rank
      get :reserach_course
    end
  end

end
