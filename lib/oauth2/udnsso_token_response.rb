require "oauth2"
require "json"

module OAuth2
  class UdnssoTokenResponse  < OAuth2::AccessToken
    attr_reader :accessToken, :userInfo, :admin

    def from_hash(client, hash)
      new(client, hash.delete('accessToken') || hash.delete(:accessToken), hash)
    end

    def initialize(client, token, opts = {})
      @client = client
      @token = token.to_s
      [:accessToken, :userInfo, :admin].each do |arg|
        arg_str = opts.delete(arg) || opts.delete(arg.to_s)

        arg_val = arg_str 
        if arg_str.is_a?(String)
          arg_val = JSON.parse arg_str
        end
        
        instance_variable_set("@#{arg}", arg_val)
      end
      
    end

    def to_s
      "UdnssoTokenResponse: accessToken-#{accessToken} || userInfo-#{userInfo} || admin-#{admin}"
    end

  end
end  