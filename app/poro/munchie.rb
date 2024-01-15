class Munchie
  attr_reader :id, :destination_city, :restaurant, :forecast

  def initialize(destination_city, restaurant, forecast)
    @id = nil
    @destination_city = destination_city
    @restaurant = restaurant
    @forecast = forecast
  end
  
end