class Login < ActiveInteraction::Base
  string :email
  string :password

  def execute

    user  = User.find_by(email:self.email)

    if user.present? && user.authenticate(self.password)
      token = JsonWebToken.new.jwt_encode({email:user.email})
      user =  user.as_json
      data = {}
      data[:user] = user
      data[:jwt] = token
      puts token
      return data
    else
      return {error: "Incorrect username or password."}
    end
  end
end