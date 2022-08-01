# frozen_string_literal: true

Rails.application.routes.draw do
  resources :session, only: [] do
    collection do
      post :sign_up, :sign_in
    end
  end

  resources :alerts, only: %i[create index destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
