require 'json'

module Mattermost
	module Endpoint
		module Webhooks

			def create_incoming_webhook(incoming_webhook)
				post("/hooks/incoming", :body => incoming_webhook.to_json)
			end

			def list_incoming_webhooks(team_id, max = 60)
				get("/hooks/incoming?per_page=#{max}&team_id=#{team_id}")
			end

			def list_incoming_webhooks_for_system(max = 60)
				get("/hooks/incoming?per_page=#{max}")
			end

			def get_incoming_webhook(hook_id)
				get("/hooks/incoming/#{hook_id}")
			end

			def update_incoming_webhook(hook_id, incoming_webhook)
				put("/hooks/incoming/#{hook_id}", :body => incoming_webhook.to_json)
			end

			def create_outgoing_webhook(outgoing_webhook)
				post("/hooks/outgoing", :body => outgoing_webhook.to_json)
			end

			def list_outgoing_webhooks(team_id, max = 60)
				get("/hooks/outgoing?per_page=#{max}&team_id=#{team_id}")
			end

			def list_outgoing_webhooks(team_id, channel_id, max = 60)
				get("/hooks/outgoing?per_page=#{max}&team_id=#{team_id}&channel_id=#{channel_id}")
			end
	
			def list_outgoing_webhooks_for_system(max = 60)
				get("/hooks/outgoing?per_page=#{max}")
			end

			def get_outgoing_webhook(hook_id)
				get("/hooks/outgoing/#{hook_id}")
			end

			def delete_outgoing_webhook(hook_id)
				delete("/hooks/outgoing/#{hook_id}")
			end

			def update_outgoing_webhook(hook_id, outgoing_webhook)
				put("/hooks/outgoing/#{hook_id}", outgoing_webhook.to_json)
			end

			def regenerate_outgoing_webhook_token(hook_id)
				post("/hooks/outgoing/#{hook_id}/regen_token")
			end
		end
	end
end
