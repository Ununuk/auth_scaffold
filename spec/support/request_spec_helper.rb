module RequestSpecHelper
  # Parse JSON response to ruby hash
  def response_json_data
    response.parsed_body["data"]
  end

  def response_error_message
    response.parsed_body["error"]
  end
end
