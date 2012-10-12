task :backup_and_load_db => :environment do
    begin
      tmp_path = File.expand_path(File.join(Rails.root, 'tmp'))

      app = "production-ouranos"

      puts "capturing a new backup..."
      capture_output = `heroku pgbackups:capture --app #{app} --expire`

      backup_id = capture_output.split("\n\n").first.split("--->  ")[1]
      puts "creating url for backup: #{backup_id}"

      backup_url = `heroku pgbackups:url #{backup_id} --app #{app}`
      puts "created url: #{backup_url}"

      backup_file = File.join(tmp_path, "#{backup_id}.dump")

      puts "downloading dump file..."

      open(backup_url) do |src|
        File.open(backup_file,"wb") do |dst|
          dst.write(src.read)
        end
      end

      puts "download complete. saved to: #{backup_file}"

      puts "loading dump file to database: yourdb_#{Rails.env}"

      # this could be specified differently, but worked out for the places i needed to use this
      user = `whoami`.to_s.chomp.strip

      # restore the database from the dumpfile
      restore_command = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U #{user} -d yourdb_#{Rails.env} #{backup_file}"
      puts restore_command
      `#{restore_command}`

      puts "load complete!"

      # find all existing dumpfiles
      previous_dumps = []
      Dir.new(tmp_path).each do |f|
        previous_dumps << f if f.to_s =~ /^.*.dump/
      end

      # delete the oldest dump keeping a max of 5
      if previous_dumps.size > 5
        File.delete(File.join(tmp_path, previous_dumps.sort.first))
        puts "removed oldest backup"
      end

    rescue Exception => e

      # if anything goes wrong notify me
      # we were already using Hoptoad in our app
      # if not using hoptoad this could be just an email
      HoptoadNotifier.notify(
        :error_class   => "HerokuDatabaseBackupError",
        :error_message => e.message
      )
    end
  end
