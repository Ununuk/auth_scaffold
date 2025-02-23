# https://github.com/waiting-for-dev/devise-jwt/pull/23
# https://github.com/plataformatec/devise/issues/4584

module Devise
  module JWT
    module WardenStrategy
      def authenticate!
        super
        env['devise.skip_trackable'.freeze] = true if valid?
      end
    end
  end
end

Warden::JWTAuth::Strategy.prepend Devise::JWT::WardenStrategy
