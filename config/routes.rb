Rails.application.routes.draw do

  devise_for :users
  resources :jobs
  resources :accounts
  root "jobs#index"

  namespace :admin do
    resources :jobs
  end

end
