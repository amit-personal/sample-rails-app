source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# ruby --version 2.4.2
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.5'

# Use sqlite3 as the database for Active Record
gem 'pg', '0.21.0'

# Use Puma as the app server
gem 'puma', '3.11.2'

# gem to load environment variables from .env
gem 'dotenv-rails', '2.2.1'

# Use SCSS for stylesheets
gem 'sass-rails', '5.0.7'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '4.1.6'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '4.2.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '5.1.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.7.0'

# Use for generating fake records in seed file
gem 'faker', branch: 'master', git: 'https://github.com/stympy/faker.git'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use for user authentication
gem 'devise'

# Use for admin interface
gem 'activeadmin', '1.1.0'

# Use for pulling rss data
gem 'feedjira', '2.1.4'

# Use for cron job
gem 'whenever', require: false

# Use for jquery events
gem 'jquery-ui-rails', '6.0.1'

# Use for Datetime picker
gem 'active_admin_datetimepicker', '0.6.1'

# Use for replacement for the URI implementation
gem 'addressable', '2.5.2'

# Simple (but safe) token authentication for Rails apps or API with Devise
gem 'simple_token_authentication', '1.15.1'

# Use for rapid API development with great conventions
gem 'grape', '1.0.2'

# Add auto generated documentation to your Grape API that can be displayed with Swagger.
gem 'grape-swagger', '0.28.0'

gem 'grape-swagger-ui', '2.2.8'

gem 'closure_tree'
gem 'bootstrap-sass'
gem 'acts_as_tree'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '2.18.0'

  # Use for test cases
  gem 'selenium-webdriver'

  # Use for split the records in console for easy to understand
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '3.5.1'

  gem 'listen', '3.1.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'spring-watcher-listen', '2.0.1'
end

