namespace :regular_mail do
  task sample: :environment do
    users=User.all
    users.each do |user|
      NotificationMailer.send_regular_to_user(user).deliver_now
    end
  end
end
