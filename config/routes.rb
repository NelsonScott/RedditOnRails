RedditOnRails::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :comments, only: [:create, :show]
  resources :subs
  resources :links do
    resources :comments, only: [:new]
    member do
      post "downvote"
      post "upvote"
    end
  end

  root to: redirect("/subs")
end
