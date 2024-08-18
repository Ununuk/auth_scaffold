module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json
    skip_before_action :verify_authenticity_token

    private

    def respond_with(current_user, _opts = {})
      if resource.persisted?
        render json: UserSerializer.new(current_user).serialized_json, status: :created
      else
        render json: { error: current_user.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    end
  end
end
