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
  
  match '/admin/pages/:id/edit', :to => 'pages#edit', :as => "friendly"

  match '/admin', :to => "admin/pages#index"

  match 'admin/modules', :controller => 'admin/modules', :action => 'index'

  match 'admin/assets', :controller => 'admin/assets', :action => 'index'

  match 'admin/settings', :controller => 'admin/settings', :action => 'index'

  match 'update_sort', :controller => 'admin/pages', :action => 'update_sort'

  match 'edit_admin_settings', :controller => 'admin/settings', :action => 'edit_admin_settings'

  match 'add_module', :controller => 'admin/settings', :action => 'add_module'

  match 'edit_module', :controller => 'admin/settings', :action => 'edit_module'

  match 'clear_api_cashes', :controller => 'admin/settings', :action => 'clear_api_cashes'

  match 'force_reload_posts', :controller => 'admin/posts', :action => 'force_reload_posts'

  match 'force_reload_galleries', :controller => 'admin/galleries', :action => 'force_reload_galleries'

  match 'force_reload_videos', :controller => 'admin/videos', :action => 'force_reload_videos'

  match ':id', :to => 'pages#show', :as => "friendly"
  root :to => "pages#index"
end

