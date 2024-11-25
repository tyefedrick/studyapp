require 'active_support'
require 'active_support/core_ext/string'

controller_files = Dir.glob('app/controllers/*_controller.rb')

controller_files.each do |controller_file|
  controller_name = File.basename(controller_file, '_controller.rb').camelize
  test_file = "test/controllers/#{controller_name.underscore}_controller_test.rb"

  unless File.exist?(test_file)
    system("rails generate test_unit:scaffold #{controller_name}")
  end
end

# Run this command to generate test files for controllers. --- ruby script/generate_missing_tests.rb
