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

  match 'add_admin_settings', :controller => 'admin/settings', :action => 'add_admin_settings'

  match 'add_module', :controller => 'admin/settings', :action => 'add_module'

  match 'edit_module', :controller => 'admin/settings', :action => 'edit_module'

  match 'clear_api_cashes', :controller => 'admin/settings', :action => 'clear_api_cashes'

  root :to => "admin/pages#index"
end

