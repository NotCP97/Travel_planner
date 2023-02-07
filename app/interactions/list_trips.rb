class ListTrips < ActiveInteraction::Base

  integer :trip_id

  def execute



    return Trip.where(id:self.trip_id).as_json

  end

end
