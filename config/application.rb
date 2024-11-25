require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Studyapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Autoload and eager load the 'lib' directory, excluding specified subdirectories.
    # The 'ignore' option should list subdirectories within 'lib' that do not contain
    # Ruby files or should not be autoloaded/eager loaded.
    config.autoload_lib(ignore: %w[assets tasks])

    # Set the application's time zone.
    config.time_zone = "Central Time (US & Canada)"

    # Add additional directories to the eager load paths if needed.
    # For example, to include the 'extras' directory:
    # config.eager_load_paths << Rails.root.join("extras")

    # Configure session store to use cookies, ensuring session persistence.
    config.session_store :cookie_store, key: "_studyapp_session"

    # Ensure middleware for session management is included.
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: "_studyapp_session"
  end
end
