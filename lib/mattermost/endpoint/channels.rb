require 'json'

module Mattermost
	module Endpoint
		module Channels
			def create_channel(channel = {})
				post("/channels", :body => channel.to_json)
			end

			def create_direct_channel(user_id_1, user_id_2)
				post("/channels/direct", :body => JSON.generate([user_id_1, user_id_2]))
			end

			def create_group_message(user_ids = [])
				post("/channels/group", :body => JSON.generate(user_ids))
			end

			def get_channel_list_by_ids(team_id, channel_ids = [])
				post("/teams/#{team_id}/channels/ids", :body => JSON.generate(channel_ids))
			end

			def get_channel(channel_id)
				get("/channels/#{channel_id}")
			end

			def update_channel(channel_id, channel = {})
				put("/channels/#{channel_id}", channel.to_json)
			end

			def delete_channel(channel_id)
				delete("/channels/#{channel_id}")
			end

			def patch_channel(channel_id, patch = {})
				put("/channels/#{channel_id}/patch", patch.to_json)
			end

			def restore_channel(channel_id)
				post("/channels/#{channel_id}/restore")
			end

			def get_channel_stats(channel_id)
				get("/channels/#{channel_id}/stats")
			end

			def get_pinned_posts(channel_id)
				get("/channels/#{channel_id}/pinned")
			end

			def get_public_channels(team_id, max = 60)
				get("/teams/#{team_id}/channels?per_page=#{max}")
			end

			def get_deleted_channels(team_id, max = 60)
				get("/teams/#{team_id}/channels/deleted?per_page=#{max}")
			end

			def search_channels(team_id, term)
				post("/teams/#{team_id}/channels/search", :body => {:term => term}.to_json)
			end

			def get_channel_by_name(team_id, channel_name)
				get("/teams/#{team_id}/channels/name/#{channel_name}")
			end

			def get_channel_by_name_and_team_name(team_name, channel_name)
				get("/teams/name/#{team_name}/channels/name/#{channel_name}")
			end

			def get_channel_members(channel_id, max = 60)
				get("/channels/#{channel_id}/members?per_page=#{max}")
			end

			def add_user_to_channel(channel_id, user_id)
				post("/channels/#{channel_id}/members", :body => {:user_id => user_id}.to_json)
			end

			def get_channel_members_by_ids(channel_id, user_ids = [])
				post("/channels/#{channel_id}/members/ids", :body => JSON.generate(user_ids))
			end

			def get_channel_member(channel_id, user_id)
				get("/channels/#{channel_id}/members/#{user_id}")
			end

			def remove_user_from_channel(channel_id, user_id)
				delete("/channels/#{channel_id}/members/#{user_id}")
			end

			def update_channel_roles(channel_id, user_id, roles)
				put("/channels/#{channel_id}/members/#{user_id}/roles", :body => {:roles => roles}.to_json)
			end

			def update_channel_notifications(channel_id, user_id, notify_props = {})
				put("/channels/#{channel_id}/members/#{user_id}/notify_props", notify_props.to_json)
			end

			def view_channel(user_id, channel_id, prev_channel_id)
				post("/channels/members/#{user_id}/view", :body => {
					:channel_id => channel_id,
					:prev_channel_id => prev_channel_id
				}.to_json)
			end

			def get_channel_members_for_user(user_id, team_id)
				get("/users/#{user_id}/teams/#{team_id}/channels/members")
			end

			def get_channels_for_user(user_id, team_id)
				get("/users/#{user_id}/teams/#{team_id}/channels")
			end

			def get_unread_messages(user_id, channel_id)
				get("/users/#{user_id}/channels/#{channel_id}/unread")
			end
		end
	end
end
