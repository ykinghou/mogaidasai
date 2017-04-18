Rails.application.routes.draw do




  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :jobs


  namespace :admin do
    resources :jobs
  end

  root "jobs#index"
end
