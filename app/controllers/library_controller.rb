class LibraryController < ApplicationController
  skip_before_action :require_authentication, only: [ :public_action ]

  def index
    # Requires authentication
  end

  def public_action
    # Accessible without authentication
  end
end
