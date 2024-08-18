class ApiController < ActionController::API
  protected

  def render_json(data, serializer:, meta: {}, status: :ok)
    render json: data, status: status and return unless serializer
    render json: serializer.new(data, meta:).serialized_json, status: status and return if meta.present?

    render json: serializer.new(data).serialized_json, status:
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
