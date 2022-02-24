# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root 'pages#index'

    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update]

    resources :quests do
      resources :answers, except: %i[new show]
    end

    namespace :admin do
      resources :users, only: %i[index create]
    end
  end
end
