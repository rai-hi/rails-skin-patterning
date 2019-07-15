# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#show'

  resource :skin_simulation
end
