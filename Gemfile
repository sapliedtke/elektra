# encoding: UTF-8
source 'http://localhost:8080/rubygemsorg/'
source 'https://localhost/' do
  gem 'ruby-arc-client', '~> 0.6.0'
end
# Avoid g++ dependency https://github.com/knu/ruby-domain_name/issues/3
# # unf is pulled in by the ruby-arc-client
gem 'unf', '>= 0.2.0beta2'

gem 'rails', '4.2.4'


# Views and Assets
gem 'compass-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'simple_form'
gem 'redcarpet'
gem 'spinners'
gem 'sass_inline_svg'
gem 'friendly_id'
gem 'high_voltage'
gem 'simple-navigation' # Navigation menu builder
gem 'font-awesome-sass'

gem 'responders'

# Database
gem 'pg'
gem 'activerecord-session_store'

# Openstack
gem 'net-ssh'
#gem 'fog-openstack' ### NOTE: when re-enabling this, update the branch for fog-openstack-monitoring to master
gem 'fog', git: 'git://localhost/monsoon/fog.git', branch: 'master'
gem 'fog-openstack-monitoring', git: 'git://localhost/***REMOVED***/fog-openstack-monitoring.git', branch: 'based-on-old-fog-gem'

gem 'monsoon-openstack-auth', git: 'git://localhost/monsoon/monsoon-openstack-auth.git', branch: :master
#gem 'monsoon-openstack-auth', path: '../monsoon-openstack-auth'

#gem 'converged_cloud_bootstrap', git: 'git://localhost/monsoon/converged_cloud_bootstrap.git'
#gem 'converged_cloud_bootstrap', path: '../converged_cloud_bootstrap'

# Extras
gem 'config'

# Prometheus instrumentation
gem 'prometheus-client'


###################### PLUGINS #####################
# backlist plugins 
black_list = [] #e.g. ['compute']

Dir.glob("plugins/*").each do |plugin_path|
  unless black_list.include?(plugin_path.gsub('plugins/', ''))
    gemspec path: plugin_path
  end
end
######################## END #######################


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Avoid double log lines in development
# See: https://github.com/heroku/rails_stdout_logging/issues/1
group :production do
  gem 'rails_stdout_logging'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # We stick to 2.x until this is fixed:
  # https://github.com/banister/binding_of_caller/issues/59
  gem 'puma', '~> 2.16'
end

group :development, :test do
  # load .env
  gem 'dotenv-rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem "foreman"

  # Testing
  gem "rspec"
  gem "rspec-rails"
  gem "factory_girl_rails", "~> 4.0"
  gem "cucumber-rails", require: false
  gem "capybara"
  gem "database_cleaner"
  #gem 'phantomjs'

  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'capybara-screenshot'


  gem "better_errors"
  gem 'pry-rails'
end

group :test do
  gem 'guard-rspec'
end
