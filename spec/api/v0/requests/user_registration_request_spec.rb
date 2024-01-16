require 'rails_helper'

RSpec.describe "Create a New User", type: :request do
  before :each do
    user_info = {
                "email": "chisPwants2code@goodgirl.com",
                "password": "dogeatworld",
                "password_confirmation": "dogeatworld"
              }

    post "/api/v0/users", params: user_info

    expect(response).to be_successful
    @response = JSON.parse(response.body, symbolize_names: true)[:data]
    @attributes = @response[:attributes]
  end

  describe "JSON User Registration Response" do
    it 'create a response that holds a type, id, and attribute following proper JSON format' do
      expect(@mpls_forecast).to have_key(:id)
      expect(@mpls_forecast).to have_key(:type)
      expect(@mpls_forecast[:type]).to eq("users")
      expect(@mpls_forecast).to have_key(:attributes)
    end

    xit 'attributes contain e-mail and a custom API key for that user' do
      expect(@attributes).to have_key(:email)
      expect(@attributes).to have_key(:api_key)
      expect(@attributes).to_not have_key(:password)
    end

    xit 'contains the user e-mail that was inputted' do
      expect(@attributes[:email]).to eq("chisPwants2code@goodgirl.com")
    end
  end

end