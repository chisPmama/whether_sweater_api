class ApplicationController < ActionController::API
  def find_coordinates
    if params[:location]
      location = params[:location]
      CoordinateFacade.new.get_coordinates(location)
    else
      destination = params[:destination]
      coordinates = CoordinateFacade.new.get_coordinates(destination)
    end
  end
end
