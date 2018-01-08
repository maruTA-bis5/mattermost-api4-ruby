require_relative 'mattermost/client'

module Mattermost

	def new_client(server)
		Mattermost::Client.new server
	end
end
