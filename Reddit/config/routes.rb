Rails.application.routes.draw do
  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]

  root to: redirect('/subs')
end
