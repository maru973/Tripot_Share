Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    invitations: 'users/invitations'
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
    member do
      get 'new_spots'
      get 'course'
      post 'invitation'
      get 'invitation/accept/:invitation_token', to: 'plans#accept', as: 'accept'
      
      #今後必要があれば
      # get 'courses'
    end
  end


  resources :courses
  resource :spots, only: %i[create destroy]

  resource :mypage, only: %i[show edit destroy update]
  get 'myplans', to: 'mypages#myplans'
  get 'mycourses', to: 'mypages#mycourses'

end
