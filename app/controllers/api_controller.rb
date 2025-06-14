class ApiController < ActionController::API
  before_action :set_active_storage_url_options if Rails.env.development?

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = { host: request.base_url }
  end

  protected

  def render_json(data, serializer:, meta: {}, include: [], status: :ok)
    render json: data, status: status and return unless serializer
    render json: serializer.new(data, meta:, include:).serializable_hash, status: status and return if meta.present?

    render json: serializer.new(data, include:).serializable_hash, status:
  end

  def render_error(message, status: :unprocessable_entity)
    render json: { error: message }, status:
  end

  def meta(collection)
    return {} if params[:page].blank?

    {
      pagination: {
        current_page: params[:page].to_i,
        per_page: params[:per_page].present? ? params[:per_page].to_i : 10,
        total_pages: collection.total_pages,
        total_objects: collection.total_count
      }
    }
  end
end
