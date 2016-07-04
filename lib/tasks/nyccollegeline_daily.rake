namespace :nyccollegeline_daily do

  task :send_digest => :environment do
    User.subscribed_to_digests.each do |subscriber|
      subscriber.delay(queue: 'digest').send_daily_digests
    end
  end

end
