# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include DeviseableJsonApi
    include JsonRenderable

    private

    def respond_with(current_user, _opts = {})
      render_json(current_user, serializer: UserSerializer, status: :ok)
    end

    def respond_to_on_destroy
      if current_user
        render_json({ message: "Logged out successfully" }, status: :ok)
      else
        render_error("No active session", status: :unauthorized)
      end
    end
  end
end
