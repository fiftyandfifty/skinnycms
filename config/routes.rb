RailsRoot::Application.routes.draw do
  # define your skinnycms routes here, for example:
  # resources :news, :controller => 'skinnycms/news'

  namespace :admin do
    resources :pages
  end
end

