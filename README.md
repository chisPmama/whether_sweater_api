## Ruby Version
This project repo runs on Rails 7.0.8.

## API References
This API uses two different external APIs:

1. [MapQuest](https://developer.mapquest.com/) - used for location to coordinate conversion as well as directions to calculate arrival times
2. [Weather API](https://www.weatherapi.com/) - used for current, daily (upto 5 days), hourly (24 hours), and estimated time of arrival weather information

### For API Set-Up:
Both APIs require user logins that will provide the API key for you through each respective User Profile. 

1. Use the following command: `EDITOR="code --wait" rails credentials:edit` 

2. This will open up the `credentials.yml.enc` file where the keys need to be formatted in this layout:

```
mapquest:
  key: [provided-key]

weatherapi:
  key: [provided-key]
```

3. Close the window to save the credentials, this will match up with the API key replacements I.E. `Rails.application.credentials.mapquest[:key]`

## Running the Test Suite
1. Run `rails db:migrate` in the terminal to begin the setup for this API
2. Run `bundle install` in the terminal to include the necessary gems
3. Run `bundle exec rspec` to access the tests written in the rspec folder