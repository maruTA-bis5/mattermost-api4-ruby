require 'json'

module Mattermost
	module Endpoint
		module Commands

			def create_command(command)
				post("/commands", :body => command.to_json)
			end

			def list_commands(team_id, custom_only = false)
				get("/commands?team_id=#{team_id}&custom_only#{custom_only}")
			end

			def list_autocomplete_commands(team_id)
				get("/teams/#{team_id}/commands/autocomplete")
			end

			def update_command(command_id, command)
				put("/commands/#{command_id}", :body => command.to_json)
			end

			def delete_command(command_id)
				delete("/commands/#{command_id}")
			end

			def regenerate_command_token(command_id)
				put("/commands/#{command_id}/regen_token")
			end

			def execute_command(channel_id, command)
				post("/commands/execute", :body => {
					:channel_id => channel_id,
					:command => command
				}.to_json)
			end
		end
	end
end
