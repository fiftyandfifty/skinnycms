Rails.application.routes.draw do

  namespace :admin do
    resources :pages
  end
end

