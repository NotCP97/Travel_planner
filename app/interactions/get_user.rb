class GetUser < ActiveInteraction::Base
  integer :id

  def execute
    user = User.find(self.id)
    data = user.as_json
    data[:joined]  = user.joined
    data[:upcoming_trips]  = user.upcoming_trips
    data[:past_trips]  = user.past_trips
    data[:next_trip]  = user.next_trip
    data[:daysLeftTill]  = user.daysLeftTill

    return data
  end


end