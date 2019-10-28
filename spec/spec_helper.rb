# frozen_string_literal: true

require "bundler/setup"
require "pry"
require "simplecov"

require "timecop"

require "spicerack/spec_helper"
require "shoulda-matchers"

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/rspec/"
end

require "law"

require_relative "../lib/spec_helper"

require_relative "support/shared_context/with_lock_and_key_names"
require_relative "support/shared_context/with_roles_and_permissions"
require_relative "support/shared_context/with_laws_and_regulations"

require_relative "support/shared_context/with_an_example_permission"
require_relative "support/shared_context/with_an_example_regulation"

require_relative "support/shared_context/with_an_example_role"
require_relative "support/shared_context/with_an_example_actor"

require_relative "support/shared_context/with_an_example_law"

require_relative "support/shared_context/with_an_example_petition"

require_relative "support/test_classes/do_anything_regulation"
require_relative "support/test_classes/administrative_regulation"
require_relative "support/test_classes/authentication_regulation"
require_relative "support/test_classes/owner_regulation"
require_relative "support/test_classes/discount_administrator_regulation"
require_relative "support/test_classes/discount_manager_regulation"

require_relative "support/test_classes/unregulated_law"
require_relative "support/test_classes/common_law"
require_relative "support/test_classes/authentication_law"
require_relative "support/test_classes/admin_law"
require_relative "support/test_classes/owner_law"
require_relative "support/test_classes/create_discount_law"

require_relative "support/test_classes/do_anything_permission"
require_relative "support/test_classes/administrative_permission"
require_relative "support/test_classes/authentication_permission"
require_relative "support/test_classes/owner_permission"
require_relative "support/test_classes/discount_administrator_permission"
require_relative "support/test_classes/discount_manager_permission"

require_relative "support/test_classes/guest_role"
require_relative "support/test_classes/user_role"
require_relative "support/test_classes/admin_role"
require_relative "support/test_classes/super_admin_role"
require_relative "support/test_classes/marketing_executive_role"
require_relative "support/test_classes/marketing_manager_role"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each, type: :with_frozen_time) { Timecop.freeze(Time.now.round) }
  config.before(:each, type: :integration) { Timecop.freeze(Time.now.round) }

  config.after(:each) { Timecop.return }
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_model
  end
end
