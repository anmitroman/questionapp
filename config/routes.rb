Rails.application.routes.draw do
  root "pages#index"

  resources :quests do
    resources :answers, except: %i[new show]
  end
end
