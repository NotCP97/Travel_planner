class CreateTrip < ActiveInteraction::Base
  string :trip_name
  date  :start_date
  date  :end_date
  integer :user_id


  def execute
    payload = {
      trip_name:self.trip_name,
      start_date: self.start_date,
      end_date:self.end_date,
      user_id:self.user_id
    }
    trip = Trip.new(payload)

    if trip.save
      return trip
    else
      {error: "Trip could not be created. Please try again."}
    end

  end


end
