source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.7'
# Use postgresql as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
 gem 'bcrypt', '~> 3.1.7'
 gem 'tzinfo-data'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
 gem 'rack-cors'
 gem 'jwt'
 gem 'simple_command'
 gem 'webpack-rails'
 gem 'webpacker', github:'rails/webpacker'
 group :development, :test do
   gem 'sqlite3', '1.3.13'
   gem 'byebug',  '9.0.6', platform: :mri
   gem 'rspec-rails'
   gem 'shoulda-matchers'
   gem 'database_cleaner'
   gem 'capybara'
   gem 'factory_girl_rails'
   gem 'faker'
 end

 group :development do
   gem 'web-console',           '3.5.1'
   gem 'listen',                '3.1.5'
   gem 'spring',                '2.0.2'
   gem 'spring-watcher-listen', '2.0.1'
 end

 group :test do
   gem 'rails-controller-testing', '1.0.2'
   gem 'guard',                    '2.13.0'
   gem 'launchy'
   gem 'guard-rspec'
   gem 'capybara'
 end
group :production do
  gem 'pg', '0.20.0'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
