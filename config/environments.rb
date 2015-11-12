#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
configure :production, :development do
	# db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/development')

	ActiveRecord::Base.establish_connection(
			:adapter => ENV['DB_ADAPTER'],
			:database => ENV['DB_DATABASE'],
			:port => ENV['DB_PORT'],
			:username => ENV['DB_USERNAME'],
			:password => ENV['DB_PASSWORD'],
			:host     => ENV['DB_HOST'],
	)
end
