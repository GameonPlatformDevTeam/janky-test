require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# https://github.com/burke/zeus/issues/180
# require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  include FactoryGirl::Syntax::Methods
  config.infer_base_class_for_anonymous_controllers = false
  config.include TimeStop
  config.include ActionFilterSetter, type: :controller
  config.include LoginHelpers, type: :controller
  config.before(:each, :behaviour_type => :controller) do
    @controller.instance_eval { flash.stub!(:sweep) } # for testing flash now
    @only_filter_chain = @controller.class.filter_chain - @controller.class.superclass.filter_chain
  end

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def mock_user(options = {})
  @mock_user ||= mock_model(User, options.reverse_merge(
    usn: "", userid: "", luserid: "", passwd: "", sex: "", email: "", lastname: "", firstname: "", birthday: "", birthdayopen: "", regdate: "", emailcheck: "", userstatus: "", logincnt2006: "", lastlogondate: "", regip: "", lastloginip: "", mailcfg: "", referer: "", regid: "", referusn: "", joinchannel: "", newslettercfg: "", macaddress: "", bloglettercfg: "", logincnt2007: "", job: "", region: "", joinpath: "", remaintime: "", logincnt: "", accountid: "", global_lev: "", local_lev: "", nick: "", old_accountid: "", profile_image: "",
    save: true, save!: true, update_attribute: true, update_attributes: true
  ))
end