class HourlyWeather

  def initialize(data)
    @id = nil
    @hourly_forecast = []
    hourly_data = Hash.new
    data[:hour].each do |data|
      hourly_data[:time] = data[:time].split[1]
      hourly_data[:temperature] = data[:temp_f]
      hourly_data[:conditions] = data[:condition][:text]
      hourly_data[:icon] = data[:condition][:icon]
      @hourly_forecast << hourly_data
    end
  end

  def to_array
    @hourly_forecast
  end
end

# date: ,
# sunrise: ,
# sunset: ,
# max_temp: ,
# min_temp: ,
# condition: ,
# icon: ,
# }