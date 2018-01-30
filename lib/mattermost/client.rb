require_relative 'endpoint'
require_relative 'request'
require_relative 'websocket_client'

module Mattermost

	class Client
		extend Gem::Deprecate
		include Mattermost::Endpoint
		include Mattermost::Request

		attr_accessor :server, :token, :headers

		# *DEPRECATED* I'll remove this method soon
		def base_uri
			"#{server}/api/v4"
		end
		deprecate :base_uri, :none, 2018, 1

		def initialize(server)
			self.server = server
			self.headers = {:Accept => "application/json"}
		end

		def login(username, password)
			login_request = post('/users/login', :body => {:login_id => username, :password => password}.to_json)
			self.token = login_request.headers['token']
			update_token
		end

		def logout
			post("/users/logout")
			self.token = nil
			update_token
		end

		def use_access_token(token)
			self.token = token
			update_token
		end

		def connected?
			get_me.success?
		end

		def connect_websocket
			# TODO raise exception then connected? == false
			@ws_client = WebSocketClient.new "#{base_uri}/websocket", token, {:headers => self.headers}
			yield @ws_client if block_given?
			@ws_client
		end

		def ws_client
			@ws_client
		end

		private

		def update_token
			headers[:Authorization] = "Bearer #{token}"
		end

	end
end
