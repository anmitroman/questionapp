Rails.application.routes.draw do
  root "pages#index"

  resources :sessions, only: %i[new create destroy]
  
  resources :users, only: %i[new create]

  resources :quests do
    resources :answers, except: %i[new show]
  end
end
