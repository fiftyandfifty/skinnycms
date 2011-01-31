Rails.application.routes.draw do

  resources :pages

  namespace :admin do
    resources :users
    resources :pages
    resources :posts
    resources :custom_modules
    resources :api_modules
    resources :assets
  end
  
  match '/admin/pages/:id/edit', :to => 'pages#edit', :as => "friendly"

  match '/admin', :to => "admin/pages#index"

  match 'admin/modules', :controller => 'admin/modules', :action => 'index'

  match 'admin/settings', :controller => 'admin/settings', :action => 'index'

  match 'update_sort', :controller => 'admin/pages', :action => 'update_sort'

  match 'edit_admin_settings', :controller => 'admin/settings', :action => 'edit_admin_settings'

  match 'add_module', :controller => 'admin/settings', :action => 'add_module'

  match 'edit_module', :controller => 'admin/settings', :action => 'edit_module'

  match 'clear_api_cashes', :controller => 'admin/settings', :action => 'clear_api_cashes'

  match 'force_reload_posts', :controller => 'admin/posts', :action => 'force_reload_posts'

  match 'force_reload_galleries', :controller => 'admin/galleries', :action => 'force_reload_galleries'

  match 'force_reload_videos', :controller => 'admin/videos', :action => 'force_reload_videos'

  match 'get_asset_by_type', :controller => 'admin/assets', :action => 'get_asset_by_type'

  match ':id', :to => 'pages#show', :as => "friendly"
  
  root :to => "pages#index"
end

