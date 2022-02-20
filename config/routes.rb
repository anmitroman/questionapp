Rails.application.routes.draw do
  root "pages#index"

  resource :session, only: %i[new create destroy]
  
  resources :users, only: %i[new create edit update]

  resources :quests do
    resources :answers, except: %i[new show]
  end
end
