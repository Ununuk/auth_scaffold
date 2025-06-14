module Users
  class PasswordsController < Devise::PasswordsController
    include DeviseableJsonApi
    include JsonRenderable

    def edit
      if User.with_reset_password_token(params[:reset_password_token])
        render_json({ message: "Reset Password Token is valid" })
      else
        render_error("Reset Password Token is invalid or expired")
      end
    end

    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)

      render_json({ message: "Reset Password Instructions email has been sent" }, status: :created)
    end

    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      process_password_reset
    end

    private

    def process_password_reset
      if resource.errors.empty?
        handle_successful_reset
      else
        render_error(resource.errors.full_messages)
      end
    end

    def handle_successful_reset
      resource.unlock_access! if unlockable?(resource)
      resource.after_database_authentication
      sign_in(resource_name, resource)
      render_json({ message: "Password has been reset" })
    end
  end
end
