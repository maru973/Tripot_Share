Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  
  get "up" => "rails/health#show", as: :rails_health_check

  root "staticpages#top"

  get '/privacy_policy', to: 'staticpages#privacy_policy'
  get '/terms_of_service', to: 'staticpages#terms_of_service'
  get '/contact_us', to: 'staticpages#contact_us'

  resources :plans do
    resources :spots, only: %i[create destroy], shallow: true
    member do
      get 'course'
      
      #今後必要があれば
      # get 'courses'
    end
  end

  resources :courses
  resources :spots, only: %i[create destroy]

  # 指定場所にマーカーをつけるための仮パス
  get '/spot_entry', to: 'plans#spot', as: 'spot_entry'

  namespace :mypage do
    resources :plans, only: [:index]
    resources :courses, only: [:index]
    resource :settings, only: %i[show update destroy]
  end
end
