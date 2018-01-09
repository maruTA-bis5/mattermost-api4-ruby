require_relative 'mattermost/client'

module Mattermost

	def self.new_client(server)
		Mattermost::Client.new server
	end
end
