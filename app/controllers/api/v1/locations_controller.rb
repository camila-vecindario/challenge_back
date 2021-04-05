class Api::V1::LocationsController < ApplicationController

  def cities
    locations = Location.where.not(location_id: nil)
    render json: locations.as_json(only: [:id, :name]), status: :ok
  end
end
