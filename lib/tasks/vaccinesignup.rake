# frozen_string_literal: true

namespace :vaccinesignup do
  desc 'Read DMs and, if there are subscriptions, notify users.'
  task :read_and_notify do
    results = NotifyBot.call
    puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
    Rails.logger.info "
  Notified #{results[:users]} users about #{results[:clinics]} appointments.
  "
  end

  desc 'Sync Locations and, if there are changes, notify users.'
  task :sync_and_notify do
    results = SyncBot.call
    puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
    Rails.logger.info "
  Notified #{results[:users]} users about #{results[:clinics]} appointments.
  "
  end
end
