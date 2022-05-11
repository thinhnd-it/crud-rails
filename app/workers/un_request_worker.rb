require 'sidekiq-scheduler'

class UnRequestWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
        puts Friendship.where('created_at <= :seven_day_ago', :seven_day_ago => Time.now - 7.days).where.not(status: 'accepted').delete_all
    end
end