require 'httparty'
require_relative 'endpoint'
require_relative 'request'

module Mattermost

	class Client
		include HTTParty
		include Mattermost::Endpoint
		include Mattermost::Request

		attr_accessor :server, :token

		def initialize(server)
			self.server = server
			self.class.base_uri "#{server}/api/v4"
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

		def get(path, options = {}, &block)
			self.class.get(path, options, &block)
		end

		def post(path, options = {}, &block)
			self.class.get(path, options, &block)
		end

		def put(path, options = {}, &block)
			self.class.get(path, options, &block)
		end

		def delete(path, options = {}, &block)
			self.class.delete(path, options, &block)
		end

		private

		def update_token
			self.class.headers :Authorization => "Bearer #{token}"
		end
	end
end
