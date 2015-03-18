# lib/tasks/db.rake

namespace :db do

  desc "Dumps the database to db/APP_NAME.dump"
  task :backup => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      puts("App:#{app}\nHost:#{host}\nDB:#{db}\nUser:#{user}")
      cmd = "mysqldump -u #{user} -p #{db} > #{Rails.root}/db/#{app}.dump"
    end
    puts cmd
    exec cmd
  end
  
  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "mysql -u #{user} -p #{db} < #{Rails.root}/db/#{app}.dump"
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  desc "Imports data from :file into :table.\nUsage: rake db:import[filename,tablename]"
  task :import, [:file,:tabl] => :environment do |t,args|
    require 'csv'
    CSV.foreach(args[:file],headers: true, header_converters: :symbol, converters: :all) do |record|
      args[:tabl].camelize.constantize.create(record.to_hash)
    end
  end

private

def with_config
yield Rails.application.class.parent_name.underscore,
ActiveRecord::Base.connection_config[:host],
ActiveRecord::Base.connection_config[:database],
ActiveRecord::Base.connection_config[:username]
end

end
