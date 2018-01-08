require 'json'

module Mattermost
	module Endpoint
		module Status

			def get_user_status(user_id)
				get("/users/#{user_id}/status")
			end

			def update_user_status(user_id, status)
				put("/users/#{user_id}/status", :body => {:status => status}.to_json)
			end

			def get_user_statuses_by_id()
				get("/users/status/ids")
			end
		end
	end
end
