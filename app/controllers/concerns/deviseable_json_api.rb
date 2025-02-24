module DeviseableJsonApi
  extend ActiveSupport::Concern

  included do
    respond_to :json
    skip_before_action :verify_authenticity_token
  end
end
