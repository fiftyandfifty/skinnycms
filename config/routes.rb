Rails.application.routes.draw do

  resources :pages

  namespace :admin do
    resources :users
    resources :pages
    resources :categories
    resources :posts
    resources :images
    resources :custom_modules
    resources :api_modules
  end

  match '/admin', :to => "admin/pages#index"

  match 'update_sort', :controller => 'admin/pages', :action => 'update_sort'

  match 'tumblr_force_reload', :controller => 'admin/posts', :action => 'force_reload'

  match 'admin/modules', :controller => 'admin/modules', :action => 'index'

  match 'admin/assets', :controller => 'admin/assets', :action => 'index'

  match 'admin/settings', :controller => 'admin/settings', :action => 'index'

  root :to => "admin/pages#index"
end

