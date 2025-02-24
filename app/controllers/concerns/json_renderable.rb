module JsonRenderable
  extend ActiveSupport::Concern

  private

  def render_error(message, status: :unprocessable_entity)
    render json: { error: message }, status:
  end

  def render_json(data, serializer: nil, meta: {}, status: :ok)
    render json: data, status: status and return unless serializer
    render json: serializer.new(data, meta:).serialized_json, status: status and return if meta.present?

    render json: serializer.new(data).serialized_json, status:
  end
end
