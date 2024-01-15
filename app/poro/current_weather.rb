class CurrentWeather
  attr_reader :id, :last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon

  def initialize(data)
    @id = nil
    @last_updated = data[:last_updated]
    @temperature = data[:temp_f]
    @feels_like = data[:feelslike_f]
    @humidity = data[:humidity]
    @uvi = data[:uv]
    @visibility = data[:vis_miles]
    @condition = data[:condition][:text]
    @icon = data[:condition][:icon]
  end

  def to_hash
    { condition: @condition,
      feels_like: @feels_like,
      humidity: @humidity,
      icon: @icon,
      last_updated: @last_updated,
      temperature: @temperature,
      uvi: @uvi,
      visibility: @visibility
    }
  end
end