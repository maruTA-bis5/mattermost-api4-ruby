require 'json'

module Mattermost
	module Endpoint
		module OAuth

			def register_oauth_app(app)
				post("/oauth/apps", :body => app.to_json)
			end

			def get_oauth_apps(max = 60)
				get("/oauth/apps?per_page=#{max}")
			end

			def get_oauth_app(app_id)
				get("/oauth/apps/#{app_id}")
			end

			def update_oauth_app(app_id, app)
				put("/oauth/apps/#{app_id}", :body => app.to_json)
			end

			def delete_oauth_app(app_id)
				delete("/oauth/apps/#{app_id}")
			end

			def regenerate_oauth_app_secret(app_id)
				post("/oauth/apps/#{app_id}/regen_secret")
			end

			def get_oauth_app_info(app_id)
				get("/oauth/apps/#{app_id}/info")
			end

			def get_authorized_oauth_apps(user_id, max = 60)
				get("/users/#{user_id}/oauth/apps/authorized?per_page=#{max}")
			end
		end
	end
end
