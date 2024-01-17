class EtaWeather
  attr_reader :id, :datetime, :temperature, :condition

  def initialize(data, travel_time, datetime)
    search_date = datetime[0..9]
    search_time = search_time_reformat(travel_time)

    target_time = search_date + " " + search_time
    found_day = data.find{|day| day[:date] == search_date} ## finding the right day
    found_hour = found_day[:hour].find{|hour| hour[:time] == target_time} ##finding the specified hour
    
    @id = nil
    @datetime = datetime
    @temperature = found_hour[:temp_f]
    @condition = found_hour[:condition][:text]
  end

  def search_time_reformat(travel_time)
    search_time = travel_time[0..1].to_i
    while search_time > 24
      search_time -= 24
    end
    if search_time == 24
      "00:00" 
    else
      format = format('%02d:00', search_time)
    end
  end

  def to_hash
    { datetime: @datetime,
      temperature: @temperature,
      condition: @condition,
    }
  end
end