require 'json'

module Mattermost
	module Endpoint
		module Plugins

			def upload_plugin(plugin)
				#post("/pkugins", plugin)
				raise NotImplementedError
			end

			def get_plugins
				get("/plugins")
			end

			def remove_plugin(plugin_id)
				delete("/plugins/#{plugin_id}")
			end

			def activate_plugin(plugin_id)
				post("/plugins/#{plugin_id}/activate")
			end

			def deactivate_plugin(plugin_id)
				post("/plugins/#{plugin_id}/deactivate")
			end

			def get_webapp_plugins
				get("/plugins/webapp")
			end
		end
	end
end
