RedditOnRails::Application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :subs
  resources :links do
    resources :comments, only: [:create, :new, :show]
    member do
      post "upvote"
      post "downvote"
    end
  end

  root to: "subs#index"
end