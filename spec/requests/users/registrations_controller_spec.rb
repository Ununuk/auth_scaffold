require "rails_helper"

RSpec.describe Users::RegistrationsController do
  describe "POST /users" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            email: "user@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      before do
        post user_registration_path, params: valid_params
      end

      it "returns created status" do
        expect(response).to have_http_status(:created)
      end

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "returns the new user" do
        expect(response_json_data["attributes"]).to eq({ "email" => User.last.email,
                                                         "id" => User.last.id })
      end
    end

    context "with invalid email" do
      let(:invalid_params) do
        {
          user: {
            email: "",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      before do
        post user_registration_path, params: invalid_params
      end

      it "returns unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "returns an error message" do
        expect(response_error_message).to include("Email can't be blank")
      end
    end

    context "with invalid password confirmation" do
      let(:invalid_params) do
        {
          user: {
            email: "user@example.com",
            password: "password",
            password_confirmation: "password1"
          }
        }
      end

      before do
        post user_registration_path, params: invalid_params
      end

      it "returns unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "returns an error message" do
        expect(response_error_message).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
