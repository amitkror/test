namespace :db do

	task :sync do
		remote_db = Rails.application.config.database_configuration['production']
		local_db = Rails.application.config.database_configuration['development']

		# Put whatever SSH string here
		host = 'nyc-collegeline'

		puts 'Syncing production database to local'

		escape_pass = remote_db['password']

		remote_dump_command = "PGPASSWORD='#{escape_pass}' pg_dump -c -U #{remote_db['username']} --disable-triggers #{remote_db['database']} "

		# `ssh -t #{host} '#{remote_dump_command}' | psql #{local_db['database']}`
		puts remote_dump_command
	end

end
