class Coordinates
  attr_reader :id, :lat, :lon

  def initialize(data)
    @id = nil
    @lat = data[:lat]
    @lon = data[:lng]
  end
end