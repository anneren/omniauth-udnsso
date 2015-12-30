require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Udnsso < OmniAuth::Strategies::OAuth2
      option :name, 'udnsso'

      option :client_options, {
        :site => 'http://udn.yyuap.com/',
        :authorize_url => 'http://udn.yyuap.com/sso/admin.php/Home/Public/login',
        :token_url => 'http://udn.yyuap.com/sso/admin.php/Home/Token/getToken/'
      }


      def request_phase
        super
      end
      
      def authorize_params
        {
          :client_id => options.client_id, 
          :redirect_uri => callback_url, 
          :response_type => 'code', 
          :ajax => 'false'
          :state => 'udnssorenmian'
        }
      end

      uid do
        raw_info['uid']
      end

      info do
        {
          'email' => raw_info['email'],
          'username' => raw_info['username'],
          'mobilestatus' => raw_info['mobilestatus']
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('userInfo').parsed
      end

      protected
      def build_access_token
        params = {
          'appid' => client.id, 
          'secret' => client.secret,
          'code' => request.params['code'],
          'grant_type' => 'authorization_code' 
          }.merge(token_params.to_hash(symbolize_keys: true))
        client.get_token(params, deep_symbolize(options.auth_token_params))
      end

    end
  end
end

OmniAuth.config.add_camelization 'udnsso', 'Udnsso'
