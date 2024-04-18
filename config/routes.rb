Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  
  get "up" => "rails/health#show", as: :rails_health_check

  root "staticpages#top"

  get '/privacy_policy', to: 'staticpages#privacy_policy'
  get '/terms_of_service', to: 'staticpages#terms_of_service'
  get '/contact_us', to: 'staticpages#contact_us'

  resources :lists

  namespace :mypage do
    resources :posts, only: [:index]
    resource :settings, only: %i[show update destroy]
  end
end
