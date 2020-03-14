set :output, File.join(Whenever.path, "log", "cron.log")
set :environment, :development # 環境を設定
env :PATH, ENV['PATH']
job_type :rbenv_rake, %q!eval "$(rbenv init -)"; cd :path && :environment_variable=:environment bundle exec rake :task --silent :output!

every 1.days do
  rake 'regular_mail:sample'
end