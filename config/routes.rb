BradleyOnline::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :posts, :only => [:index, :show] do
    resources :comments, :only => [:new, :create]
  end
  root :to => 'posts#index'
end
