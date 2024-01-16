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
    expect(response.status).to eq(201)

    @result = JSON.parse(response.body, symbolize_names: true)[:data]
    @attributes = @result[:attributes]
  end

  describe "JSON User Registration Response" do
    it 'create a response that holds a type, id, and attribute following proper JSON format' do
      expect(@result).to be_a(Hash)
      expect(@result).to have_key(:id)
      expect(@result).to have_key(:type)
      expect(@result[:type]).to eq("users")
      expect(@result).to have_key(:attributes)
    end

    xit 'attributes contain e-mail and a custom API key for that user' do
      expect(@attributes).to have_key(:email)
      expect(@result).to be_a(String)

      expect(@attributes).to have_key(:api_key)
      expect(@result).to be_a(String)
      
      expect(@attributes).to_not have_key(:password)
    end

    it 'contains the user e-mail that was inputted' do
      expect(@attributes[:email]).to eq("chisPwants2code@goodgirl.com")
    end
  end

end