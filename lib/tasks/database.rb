namespace :database do

  desc "Copy production database to local"
  task :sync => :environment do
    system 'mongodump -h flame.mongohq.com:27053 -d YOUR_HEROKU_APP_NAME -u heroku -p HEROKU_PASSWORD -o db/backups/'
    system 'mongorestore -h localhost --drop -d DEV_DATABASE_NAME db/backups/YOUR_HEROKU_APP_NAME/'
  end

end