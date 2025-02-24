require "devise/jwt/test_helpers"

module DeviseJwtHelper
  def valid_authorization_headers(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end
end
