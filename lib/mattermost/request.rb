require 'faraday'
require 'faraday_middleware'

module Mattermost
	module Request

		def get(path, options = {}, &block)
			puts "get #{path}, #{options}"
			connection.send(:get) do |request|
				request.url api(path), options
			end
		end

		def post(path, options = {}, &block)
			connection.send(:post) do |request|
				request.path = api(path)
				request.body = options[:body] if options.key? :body
			end
		end

		def put(path, options = {}, &block)
			connection.send(:put) do |request|
				request.path = api(path)
				request.body = options[:body] if options.key? :body
			end
		end

		def delete(path, options = {}, &block)
			connection.send(:delete) do |request|
				request.path = api(path)
				request.body = options[:body] if options.key? :body
			end
		end

		private

		def connection
			Faraday::Connection.new({
				:headers => self.headers,
				:url => server
			}) do |connection|
				connection.response :json
				connection.adapter :httpclient
			end
		end

		def api(path)
			"/api/v4#{path}"
		end

	end
end
