module Users
  class RegistrationsController < Devise::RegistrationsController
    include DeviseableJsonApi
    include JsonRenderable

    private

    def respond_with(current_user, _opts = {})
      if resource.persisted?
        render_json(current_user, serializer: UserSerializer, status: :created)
      else
        render_error(current_user.errors.full_messages)
      end
    end
  end
end
