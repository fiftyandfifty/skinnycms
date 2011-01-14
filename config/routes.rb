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

  match 'admin/modules', :controller => 'admin/modules', :action => 'index'

  match 'admin/assets', :controller => 'admin/assets', :action => 'index'

  match 'admin/settings', :controller => 'admin/settings', :action => 'index'

  match 'update_sort', :controller => 'admin/pages', :action => 'update_sort'

  match 'edit_admin_settings', :controller => 'admin/settings', :action => 'edit_admin_settings'

  match 'add_module', :controller => 'admin/settings', :action => 'add_module'

  match 'edit_module', :controller => 'admin/settings', :action => 'edit_module'

  match 'clear_api_cashes', :controller => 'admin/settings', :action => 'clear_api_cashes'

  match 'update_cached_posts', :controller => 'admin/posts', :action => 'update_cached_posts'

  match 'update_cached_galleries', :controller => 'admin/galleries', :action => 'update_cached_galleries'

  match 'update_cached_videos', :controller => 'admin/videos', :action => 'update_cached_videos'

  root :to => "admin/pages#index"
end

