require 'json'

module Mattermost
	module Endpoint
		module Cluster

			def get_cluster_status
				get("/cluster/status")
			end
		end
	end
end
