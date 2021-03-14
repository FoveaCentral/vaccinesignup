# frozen_string_literal: true

Rails.application.routes.draw do
  get 'notify_users' => 'application#notify_users'
  get 'read_dms' => 'application#read_dms'
  get 'sync_locations' => 'application#sync_locations'
  root to: redirect('https://twitter.com/vaccinesignup/')
end
