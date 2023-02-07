class Authorized <  ActiveInteraction::Base



  def execute
    token = request.headers["Authorization"]
    puts token
  end

end
