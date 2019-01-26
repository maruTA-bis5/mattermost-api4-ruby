require 'faraday'
require 'faraday_middleware'

module Mattermost
	module Request

		# get request with auto paging mode.
		def get(path, options = {}, &block)
			if path.include? '?per_page='
			
				# start paging with page=0
				page=0
				result=nil
				
				# loop until page size is 0
				loop do
					_path="#{path}&page=#{page}"
					# intermediate request result
					_res=get_simple(_path, options = {}, &block)

					# raise an exception if request result is not OK
					raise "Mattermost request error #{_res.body['message']}" unless _res.success?
					
					# break when no more result is available in result (body)
					break if _res.body.size==0
					
					# concatenate result body from intermediate body.
					if result==nil
						result=_res
					else
						result.body.concat _res.body
					end
					
					# incremental paging mode
					page=page+1
				end
				return result
			else
				get_simple(path, options = {}, &block)
			end
		end

		
		def get_simple(path, options = {}, &block)
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
			"#{subdir}/api/v4#{path}"
		end

	end
end
