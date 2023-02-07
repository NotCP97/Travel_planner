class ApiRouter
  def self.load
    Rails.application.routes.draw do
      puts "api_router hitting"

      $API_REGISTRY.each do |api, api_config|
        puts api
        puts api_config

        #api = 'new'
        #send("get", "/hello", to: "api##{api}")
        #send(api_config[:method], "#{api_config[:service]}/#{api}", to: "api##{api}")
        send(api_config[:method], "/#{api}", to: "api##{api}")
        #njvneon
        ApiController.define_method api.to_sym do
        end
      end
    end
  end
end
