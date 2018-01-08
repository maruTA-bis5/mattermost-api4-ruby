require 'json'

module Mattermost
	module Endpoint
		module DataRetention

			def get_data_retention_policy_details
				get("/data_retention/policy")
			end
		end
	end
end
