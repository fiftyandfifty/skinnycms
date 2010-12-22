Rails.application.routes.draw do

  resources :pages

  namespace :admin do
    resources :users
    resources :pages
    resources :categories
    resources :posts
  end

  match '/admin', :controller => "admin/dashboard", :action => "index"

  match 'update_sort', :controller => 'admin/pages', :action => 'update_sort'

  match 'tumblr_force_reload', :controller => 'admin/posts', :action => 'force_reload'

  root :to => "admin/pages#index"
end

