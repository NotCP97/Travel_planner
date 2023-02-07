class ListPlaces < ActiveInteraction::Base

  integer :trip_id

  def execute

    return Place.where(trip_id:self.trip_id).as_json

  end

end
