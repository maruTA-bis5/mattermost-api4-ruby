require 'json'

module Mattermost
	module Endpoint
		module Preferences

			def get_user_preferences(user_id)
				get("/users/#{user_id}/preferences")
			end

			def save_user_perferences(user_id, preferences = [])
				put("/users/#{user_id}/preferences", :body => JSON.generate(preferences))
			end

			def delete_user_preferences(user_id, preferences = [])
				post("/users/#{user_id}/preferences/delete", :body => JSON.generate(preferences))
			end

			def list_user_preferences_by_category(user_id, category)
				get("/users/#{user_id}/preferences/#{category}")
			end

			def get_user_preference(user_id, category, preference_name)
				get("/users/#{user_id}/preferences/#{category}/name/#{preference_name}")
			end
		end
	end
end
