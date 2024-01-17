require 'rails_helper'

RSpec.describe "Login a User", type: :request do
  
  describe "JSON User Login Return with API Key" do
    before :each do
      instantiate_chisP
      
      user_info = {
                  "email": "chisPwants2code@goodgirl.com",
                  "password": "dogeatworld",
                }
  
      post "/api/v0/sessions", params: user_info
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      @result = JSON.parse(response.body, symbolize_names: true)[:data]
      @attributes = @result[:attributes]
    end

    it 'create a response that holds a type, id, and attribute following proper JSON format' do
      expect(@result).to be_a(Hash)
      expect(@result).to have_key(:id)
      expect(@result).to have_key(:type)
      expect(@result[:type]).to eq("users")
      expect(@result).to have_key(:attributes)
    end

    it 'attributes contain e-mail and a custom API key for that user' do
      expect(@attributes).to have_key(:email)
      expect(@attributes[:email]).to be_a(String)

      expect(@attributes).to have_key(:api_key)
      expect(@attributes[:api_key]).to be_a(String)

      expect(@attributes).to_not have_key(:password)
    end

    it 'contains the user e-mail that was inputted' do
      expect(@attributes[:email]).to eq("chisPwants2code@goodgirl.com")
    end
  end

  describe "Sad Path Handling" do
    before :each do
      user_info = {
                  "email": "chisPwants2code@goodgirl.com",
                  "password": "dogeatworld12",
                }
  
      post "/api/v0/sessions", params: user_info
  
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
  
      @result = JSON.parse(response.body, symbolize_names: true)
    end

    it 'sends a JSON with the status of a 422 as well as an error message' do
      expect(@result).to be_a(Array)
      expect(@result).first[:status]).to eq("422")
      expect(@result.first[:detail]).to eq("Invalid email or password.")
    end
  end
end