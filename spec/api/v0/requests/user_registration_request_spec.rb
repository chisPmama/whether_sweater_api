require 'rails_helper'

RSpec.describe "Create a New User", type: :request do
  
  describe "JSON User Registration Response" do
    before :each do
      user_info = {
                  "email": "chisPwants2code@goodgirl.com",
                  "password": "dogeatworld",
                  "password_confirmation": "dogeatworld"
                }
  
      post "/api/v0/users", params: user_info
  
      expect(response).to be_successful
      expect(response.status).to eq(201)
  
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

  describe 'User cannot create a password if not matching' do
    before :each do
      user_info = {
                  "email": "chisPwants2code@goodgirl.com",
                  "password": "dogeatworld",
                  "password_confirmation": "dogwantsbone"
                }
  
      post "/api/v0/users", params: user_info
  
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end

    it 'sends a JSON with the status of a 422 as well as an error message' do
      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:detail]).to eq("Password and password confirmation do not match.")
    end
  end

  describe 'User cannot create an account without the email' do
    before :each do
      user_info = {
                  "email": "",
                  "password": "dogeatworld",
                  "password_confirmation": "dogeatworld"
                }
  
      post "/api/v0/users", params: user_info
  
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end

    it 'sends a JSON with the status of a 422 as well as an error message' do
      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:detail]).to eq("E-mail cannot be blank.")
    end
  end

  describe 'User cannot create an account without one of the passwords' do
    it 'sends a JSON with the status of a 422 as well as an error message' do
      user_info = {
                  "email": "chisPwants2code@goodgirl.com",
                  "password": "",
                  "password_confirmation": "dogeatworld"
                }
  
      post "/api/v0/users", params: user_info
  
      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:detail]).to eq("Missing password entry.")
    end

    it 'sends a JSON with the status of a 422 as well as an error message' do
      user_info = {
                  "email": "chisPwants2code@goodgirl.com",
                  "password": "dogeatworld",
                  "password_confirmation": ""
                }
  
      post "/api/v0/users", params: user_info
  
      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:status]).to eq("422")
      expect(data[:errors].first[:detail]).to eq("Missing password entry.")
    end
  end
end