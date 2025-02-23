class TestsController < ApiController
  before_action :authenticate_user!

  def index
    render json: { message: current_user.email.to_s }, status: :ok
  end
end
