Rails.application.routes.draw do
  root "pages#index"

  resources :quests do
    resources :answers, only: %i[create destroy]
  end
end
