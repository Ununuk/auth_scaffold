require "rails_helper"

RSpec.describe Users::SessionsController do
  let(:user) { create(:user) }

  describe "POST /login" do
    context "with valid credentials" do
      before do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the current user" do
        expect(response_json_data["attributes"]).to eq({ "email" => user.email,
                                                         "id" => user.id })
      end
    end

    context "with invalid credentials" do
      before do
        post user_session_path, params: { user: { email: user.email, password: "wrong_password" } }
      end

      it "returns an unprocessable entity response" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error message" do
        expect(response_error_message).to eq("Invalid Email or password.")
      end
    end
  end

  describe "DELETE /logout" do
    context "when the user is logged in" do
      let(:headers) { valid_authorization_headers(user) }

      before do
        delete destroy_user_session_path, headers:
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns a success message" do
        expect(response.parsed_body).to eq({ "message" => "Logged out successfully" })
      end

      it "does not allow to use the token again" do
        delete(destroy_user_session_path, headers:)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the user is not logged in" do
      before do
        delete destroy_user_session_path
      end

      it "returns an unauthorized response" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns an error message" do
        expect(response_error_message).to eq("No active session")
      end
    end
  end
end
