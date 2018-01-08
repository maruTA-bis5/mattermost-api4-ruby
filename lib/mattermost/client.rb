require 'httparty'
require_relative 'endpoint'
require_relative 'request'

module Mattermost

	class Client
		import Mattermost::Endpoint
		import Mattermost::Request

		attr_accessor :server, :token

		def initialize(server)
			self.server = server
			self.base_uri = "#{server}/api/v4"
		end

		def login(username, password)
			login_request = post('/users/login', :body => {:login_id => uername, :password => password}.to_json)
			self.token = login_request.headers['token']
			update_token
		end

		def logout
			self.token = nil
			update_token
		end

		def use_access_token(token)
			self.token = token
			update_token
		end

		def connected?
			getMe().success?
		end

		private

		def update_token
			self.headers "Authorization: Bearer #{token}"
		end
	end
end
