# frozen_string_literal: true

Rails.application.routes.draw do
  get 'notify_users' => 'application#notify_users'
  get 'parse_direct_messages' => 'application#parse_direct_messages'
  resources :locations, only: nil do
    collection do
      get 'sync'
    end
  end
end
