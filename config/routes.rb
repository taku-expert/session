Rails.application.routes.draw do
  devise_for :users
  get 'session/index'
  resources :session, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'signup#index'

  # get "signup", to: "signup#index"
  resources :signup, only: [:index, :destroy]
  resources :signup do
    collection do
      get 'step1'
      post 'step2'
      post 'step3'
      get 'complete_signup'
    end
  end

end
