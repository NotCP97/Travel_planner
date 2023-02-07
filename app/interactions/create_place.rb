class CreatePlace < ActiveInteraction::Base

  integer :trip_id
  string :place_name


  def execute
    payload = {
      trip_id:self.trip_id,
      place_name:self.place_name
    }


    place = Place.new(payload)
    if place.save
      return place
    else
      {error: "Place could not be created. Please try again."}
    end

  end


end
