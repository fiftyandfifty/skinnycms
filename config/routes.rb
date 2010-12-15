Rails.application.routes.draw do

  resources :pages

  namespace :admin do
    resources :users
    resources :pages
  end

  match 'update_sort', :controller => 'admin/pages', :action => 'update_sort'

  root :to => "admin/pages#index"
end

