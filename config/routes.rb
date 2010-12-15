Rails.application.routes.draw do

  namespace :admin do
    resources :users
    resources :pages
  end
end

