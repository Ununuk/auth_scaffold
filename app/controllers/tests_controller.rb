class TestsController < ApiController
  before_action :authenticate_user!

  def index
    render json: { message: "#{current_user.email}" }, status: :ok
  end
end
