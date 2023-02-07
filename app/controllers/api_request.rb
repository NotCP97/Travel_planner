class ApiRequest
  puts "api_request"
  attr_accessor  :interaction, :request_params,:response,:api_path,:auth_token


  def initialize(interaction,request_params,auth_token=nil)
    self.interaction = interaction
    self.request_params =  request_params
    self.auth_token = auth_token
    puts self.request_params
  end

  # auth_parameters  = "navigation_name:scope_type:view_type"





  def set_interaction

    self.interaction = self.api_path.camelize.constantize
  end

  def set_request_params(params)
    self.request_params = {}

    unless self.is_micro_service_call
      self.interaction.filters.keys.each do |filter|
        self.request_params[filter] = params[filter] if params.key?(filter)
      end
    end
    self.request_params.as_json.deep_symbolize_keys!
  end

  def set_session_data
    if api_path == "login"
      return false
    elsif self.auth_token.present?
      return true
    else
      return false
    end
  end

  # def is_unauthenticated?
  #   return false
  #
  #   self.authorization_config = {}
  #
  #   self.authorization_config.nil?
  #
  # end




  def set_response

    puts "hi interaction"
    interaction = eval(self.interaction+".run(#{self.request_params})")


    self.response = {}

    if interaction.valid?
      self.response[:result] = interaction.result
    else
      self.response[:errors] = interaction.errors.messages
    end
  end

  def is_bad_request?
    self.response[:errors].present?
  end

  def validation_errors
    self.response[:errors]
  end

  def result
    self.response[:result]
  end




end