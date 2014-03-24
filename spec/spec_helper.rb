# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!('rails')
  SimpleCov.start do
    add_filter 'spec/'
    add_filter 'config/'
    add_filter 'vendor/'
    add_filter 'db/'

    add_group 'Controllers', 'app/controllers'
    add_group 'Models', 'app/models'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Workers', 'app/workers'
  end
end

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
end


require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/rails'
require 'factory_girl'

# Removes log chatter from sidekiq
require 'sidekiq/testing'
Sidekiq::Testing.fake!
Sidekiq::Logging.logger = nil

# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before(:each) { ActionMailer::Base.deliveries.clear }

  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include Rails.application.routes.url_helpers, type: :mailer
  config.include ActionDispatch::TestProcess
  config.include AuthHelper, type: :request
end

OmniAuth.config.test_mode = true

OmniAuth.config.add_mock(:twitter, {:uid => '12345',
  :info => {
    :nickname => 'twitterhandle',
    :image => 'twitter_image'
    }
  }
)

OmniAuth.config.add_mock(:linkedin, {:uid => '12345',
  :info => {
    :email => 'bob@example.com',
    :first_name => 'Bob',
    :last_name => 'Loblaw',
    :image => 'linkedin_image'
    }
  }
)

OmniAuth.config.add_mock(:google, {:uid => '12345',
  :info => {
    :email => 'bob@example.com',
    :first_name => 'Bob',
    :last_name => 'Loblaw'
    }
  }
)

OmniAuth.config.add_mock(:facebook, {:uid => '12345',
  :info => {
    :email => 'bob@example.com',
    :first_name => 'Bob',
    :last_name => 'Loblaw',
    :image => 'facebook_image'
    }
  }
)

# OmniAuth.config.add_mock(:)

# OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
#   { "provider"=>"facebook",
#     "uid"=>"12312",
#     "info"=>
#     { "nickname"=>"bob",
#       "email"=>"bob@example.com",
#       "name"=>"Bob Loblaw",
#       "first_name"=>"Bob",
#       "last_name"=>"Loblaw",
#       "image"=>"http://graph.facebook.com/8623851/picture?type=square",
#       "urls"=>{"Facebook"=>"https://www.facebook.com/southpolesteve"},
#       "verified"=>true},
#     "credentials"=>
#     { "token"=>
#       "kljwejkqwejklqejq2e9iq9d0adu09ad9asd",
#       "expires_at"=>1695062093,
#       "expires"=>true},
#     "extra"=>
#     { "raw_info"=>
#       { "id"=>"12312",
#         "name"=>"Bob Loblaw",
#         "first_name"=>"Bob",
#         "last_name"=>"Loblaw",
#         "link"=>"https://www.facebook.com/southpolesteve",
#         "username"=>"bobloblaw",
#         "gender"=>"male",
#         "email"=>"test@example.com",
#         "timezone"=>-5,
#         "locale"=>"en_US",
#         "verified"=>true,
#         "updated_time"=>"2012-09-24T02:48:31+0000"
#       }
#     }
#   })
