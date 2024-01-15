class WeatherFacade
	def initialize
    @service = WeatherService.new
  end

	def get_current_weather(coordinates)
		current_json(@service.find_weather(coordinates))
	end

	def get_hourly_weather(coordinates)
		hourly_json(@service.find_weather(coordinates))
	end

	def get_daily_weather(coordinates)
		daily_json(@service.find_weather(coordinates))
	end
 
	private

	def json_parse(data)
		JSON.parse(data.body, symbolize_names: true)
	end
	
	def current_json(data)
    data = json_parse(data)[:current]
    CurrentWeather.new(data).to_hash
	end

	def hourly_json(data)
    data = json_parse(data)[:forecast][:forecastday].first
		HourlyWeather.new(data).to_array
	end

  def daily_json(data)
    data = json_parse(data)[:forecast][:forecastday]
		DailyWeather.new(data).to_array
	end
end