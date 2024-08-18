# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  private

  def respond_with(current_user, _opts = {})
    render json: UserSerializer.new(current_user).serialized_json, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: { message: "Logged out successfully" }, status: :ok
    else
      render json: { error: "No active session" }, status: :unauthorized
    end
  end
end
