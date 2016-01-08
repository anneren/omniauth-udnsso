require 'omniauth-oauth2'
require 'digest/md5'

module OmniAuth
  module Strategies
    class Udnsso < OmniAuth::Strategies::OAuth2
      option :name, 'udnsso'

      option :client_options, {
        :site => 'http://udn.yyuap.com/',
        :authorize_url => 'http://udn.yyuap.com/sso/admin.php/Home/Public/login',
        :token_url => 'http://udn.yyuap.com/sso/admin.php/Home/Token/getToken/',
      }

      option :provider_ignores_state, true

      def request_phase
        super
      end

      def authorize_params
        {
          :client_id => options.client_id, 
          :response_type => 'code', 
          :ajax => 'false',
          :state => 'udnssorenmian',
          :username => request.params['udn_username'],
          :userpwd => Digest::MD5.hexdigest(request.params['udn_userpwd'])
        }
      end

      def token_params
        params = super
        params.merge({:client_id => options.client_id, 
                      :client_secret => options.client_secret})
      end

      def client
        log(:info, "initialize UdnssoClient")
        ::OAuth2::UdnssoClient.new(options.client_id, options.client_secret, deep_symbolize(options.client_options))
      end

      uid do
        raw_info['uid']
      end

      info do
        {
          'email' => raw_info['email'],
          'username' => raw_info['username'],
          'name' => raw_info['username'],
          'mobilestatus' => raw_info['mobilestatus']
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        log(:debug, access_token.to_s)
        @raw_info = access_token.userInfo
      end

    end
  end
end

OmniAuth.config.add_camelization 'udnsso', 'Udnsso'
