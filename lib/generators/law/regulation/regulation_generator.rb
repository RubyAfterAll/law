# frozen_string_literal: true

module Regulation
  module Generators
    class RegulationGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      hook_for :test_framework

      def create_application_flow
        template "regulation.rb.erb", File.join("app/regulations/", class_path, "#{file_name}_regulation.rb")
      end
    end
  end
end
