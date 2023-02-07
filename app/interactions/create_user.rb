class CreateUser < ActiveInteraction::Base
  string :first_name
  string :last_name
  string :email
  string :password

  def execute
    payload = {
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email,
      password: self.password
    }

    user  = User.new(payload)
    if user.save
      user = user.as_json
      user[:joined]  = user.joined
      user[:upcoming_trips]  = user.upcoming_trips
      user[:past_trips]  = user.past_trips
      user[:next_trip]  = user.next_trip
      user[:daysLeftTill]  = user.daysLeftTill


      data[:user] = user
      data[:jwt] = JsonWebToken.new.jwt_encode({email:user.email})

      return data
    else
      {error: "User could not be created. Please try again."}
    end


  end


end
