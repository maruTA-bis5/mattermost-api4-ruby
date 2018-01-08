require 'json'

module Mattermost
	module Endpoint
		module System

			def ping
				get("/system/ping")
			end

			def recycle_database_connections
				post("/database/recycle")
			end

			def send_test_email
				post("/email/test")
			end

			def get_configuration
				get("/config")
			end

			def update_configuration(config)
				put("/config", :body => config.to_json)
			end

			def reload_configuration
				post("/config/reload")
			end

			def get_client_configuration
				get("/config/client?format=old")
			end

			def upload_license_file(file_name)
				#post("/license", license)
				raise NotImplementedError
			end

			def remove_license_file
				delete("/license")
			end

			def get_client_license
				get("/license/client?format=old")
			end

			def get_audits(max = 60)
				get("/audits?per_page=#{max}")
			end

			def invalidate_server_caches
				post("/caches/invalidate")
			end

			def get_logs(max = 60)
				get("/logs?per_page=#{max}")
			end

			def add_log_message(level, message)
				post("/logs", :body => {
					:level => level,
					:message => message
				}.to_json)
			end

			def get_webrtc_token
				get("/webrtc/token")
			end

			def get_analytics(team_id, name = 'standard')
				url = "/analytics/old?name=#{name}"
				if team_id != nil
					url = "#{url}&team_id=#{team_id}"
				end
				get(url)
			end
		end
	end
end
