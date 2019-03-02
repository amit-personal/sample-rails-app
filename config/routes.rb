Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users
  devise_scope :user do
    get 'users/:username' => 'users#show', as: :user_info
    get 'top_users' => 'users#top_users'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'links#index'

  resources :links, except: :index do
    resources :comments, only: [:create, :edit, :update, :destroy]
    post :upvote, on: :member
    post :downvote, on: :member
  end

  resources :comments, except: :new do
    post :upvote, on: :member
    get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  end
  # get '/comments' => 'comments#index'
  get '/threads' => 'comments#threads'
  get '/newest' => 'links#newest', as: :newest_links
  get '/submissions' => 'submissions#index', as: :submissions
  get '/favorites' => 'favorites#index', as: :favorites

end
