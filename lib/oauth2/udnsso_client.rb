require "oauth2"
require "omniauth"
require "json"

module OAuth2
  class UdnssoClient < OAuth2::Client
    
    def get_token(params, access_token_opts = {}, access_token_class = ::OAuth2::UdnssoTokenResponse)
      opts = {:raise_errors => options[:raise_errors], :parse => params.delete(:parse)}
      
      opts[:params] = params

      response = request(options[:token_method], token_url, opts)
      error = Error.new(response)
      OmniAuth.logger.send(:info, "Udnsso Token Respose" + response.body.to_s)
      response_body = JSON.parse response.body.to_s
      fail(error) if options[:raise_errors] && !(response_body.is_a?(Hash) && response_body['accessToken'])
      access_token_class.from_hash(self, response_body)
    end 


  end
end
