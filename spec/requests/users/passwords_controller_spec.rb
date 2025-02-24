require "rails_helper"

def generate_reset_token
  Devise.token_generator.generate(User, :reset_password_token)
end

RSpec.describe Users::PasswordsController do
  describe "POST /password" do
    context "with valid parameters" do
      let(:user) { create(:user) }
      let(:valid_params) do
        {
          user: {
            email: user.email
          }
        }
      end

      before do
        post user_password_path, params: valid_params
      end

      it "returns created status" do
        expect(response).to have_http_status(:created)
      end

      it "returns a success message" do
        expect(response.parsed_body["message"]).to eq("Reset Password Instructions email has been sent")
      end

      it "send reset password email" do
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            email: ""
          }
        }
      end

      before do
        post user_password_path, params: invalid_params
      end

      it "returns created status" do
        expect(response).to have_http_status(:created)
      end

      it "returns a success message" do
        expect(response.parsed_body["message"]).to eq("Reset Password Instructions email has been sent")
      end

      it "does not send reset password email" do
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end

  describe "GET /password/edit" do
    context "with valid reset password token" do
      raw_token, enc_token = generate_reset_token
      let(:user) { create(:user, reset_password_token: enc_token) }
      let(:valid_params) do
        {
          reset_password_token: raw_token
        }
      end

      before do
        user
        get edit_user_password_path, params: valid_params
      end

      it "returns ok status" do
        expect(response).to have_http_status(:ok)
      end

      it "returns a success message" do
        expect(response.parsed_body["message"]).to eq("Reset Password Token is valid")
      end
    end

    context "with invalid reset password token" do
      let(:invalid_params) do
        {
          reset_password_token: "invalid_token"
        }
      end

      before do
        get edit_user_password_path, params: invalid_params
      end

      it "returns not found status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        expect(response.parsed_body["error"]).to eq("Reset Password Token is invalid or expired")
      end
    end
  end

  describe "PUT /password" do
    raw_token, enc_token = generate_reset_token
    let(:user) { create(:user, reset_password_token: enc_token, reset_password_sent_at: Time.zone.now) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            reset_password_token: raw_token,
            password: "new_password",
            password_confirmation: "new_password"
          }
        }
      end

      before do
        user
        put user_password_path, params: valid_params
      end

      it "returns ok status" do
        expect(response).to have_http_status(:ok)
      end

      it "returns a success message" do
        expect(response.parsed_body["message"]).to eq("Password has been reset")
      end
    end

    context "with invalid token" do
      let(:invalid_params) do
        {
          user: {
            reset_password_token: "invalid_token",
            password: "new_password",
            password_confirmation: "new_password"
          }
        }
      end

      before do
        user
        put user_password_path, params: invalid_params
      end

      it "returns unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        expect(response.parsed_body["error"]).to eq(["Reset password token is invalid"])
      end
    end

    context "with invalid password" do
      let(:invalid_params) do
        {
          user: {
            reset_password_token: raw_token,
            password: "new_password",
            password_confirmation: "invalid_password"
          }
        }
      end

      before do
        user
        put user_password_path, params: invalid_params
      end

      it "returns unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        expect(response.parsed_body["error"]).to eq(["Password confirmation doesn't match Password"])
      end
    end
  end
end
