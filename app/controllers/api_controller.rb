class ApiController < ApplicationController
  puts "api_controller_out"
  before_action :run_api

  def run_api
    puts "api_controller_in"

    service,api_path =   request.path.split('/')

    puts api_path



    interaction = api_path.camelcase

    auth_token = request.headers["Authorization"]
    puts auth_token
    puts request.raw_post


    request_params = request.query_parameters.deep_symbolize_keys
    if  eval(request.raw_post).present?
      request_params =  request_params.merge(eval(request.raw_post)).deep_symbolize_keys
    end
    puts request_params


    @api_request = ApiRequest.new(interaction,request_params,auth_token)



    # self.interaction_params = @api_request.request_params

    if @api_request.set_session_data
      #user_email =JsonWebToken.new.jwt_dencode(auth_token)
      # if api_path == "login"
      #   return
      # end

      user = JsonWebToken.new.get_user(auth_token)

      data = user.as_json
      data[:joined]  = user.joined
      data[:upcoming_trips]  = user.upcoming_trips
      data[:past_trips]  = user.past_trips
      data[:next_trip]  = user.next_trip
      data[:daysLeftTill]  = user.daysLeftTill

      if api_path == "authorized"
         render json: data,status: :ok and return
      end

    end

    # if @api_request.is_unauthenticated?
    #   render json: {}, status: :unauthorized and return
    # end
    begin
      @api_request.set_response
    end

    if @api_request.is_bad_request?
      render json: @api_request.validation_errors, status: :bad_request and return
    end

    render json: @api_request.result, status: :ok and return
  end

end
