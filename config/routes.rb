Rails.application.routes.draw do |map|
  # define your skinnycms routes here, for example:
  # resources :news, :controller => 'skinnycms/news'

  namespace :admin do
    resources :pages
  end
end

