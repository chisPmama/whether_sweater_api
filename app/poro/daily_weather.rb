class DailyWeather
  def initialize(data)
    @id = nil
    @daily_forecast = []
    daily_data = Hash.new
    data.each do |d|
      daily_data[:date] = d[:date]
      daily_data[:sunrise] = d[:astro][:sunrise]
      daily_data[:sunset] = d[:astro][:sunset]
      daily_data[:max_temp] = d[:day][:maxtemp_f]
      daily_data[:min_temp] = d[:day][:mintemp_f]
      daily_data[:condition] = d[:day][:condition][:text]
      daily_data[:icon] = d[:day][:condition][:icon]
      @daily_forecast << daily_data
    end
  end

  def to_array
    @daily_forecast
  end
end