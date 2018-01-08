require 'json'

module Mattermost
	module Endpoint
		module Elasticsearch

			def test_elasticsearch_configuration
				post("/elasticsearch/test")
			end

			def purge_elasticsearch_indexes
				post("/elasticsearch/purge_indexes")
			end
		end
	end
end
