require 'json'

module Mattermost
	module Endpoint
		module Posts
			def create_post(post)
				post("/posts", :body => post.to_json)
			end

			def get_post(post_id)
				get("/posts/#{post_id}")
			end

			def delete_post(post_id)
				delete("/posts/#{post_id}")
			end

			def update_post(post_id, post)
				put("/posts/#{post_id}", :body => post.to_json)
			end

			def patch_post(post_id, patch)
				put("/posts/#{post_id}", :body => patch.to_json)
			end

			def get_thread(post_id)
				get("/posts/#{post_id}/thread")
			end

			def get_flagged_posts(user_id)
				get("/posts/#{user_id}/posts/flagged")
			end

			def get_file_info_for_post(post_id)
				get("/posts/#{post_id}/files/info")
			end

			def get_posts_for_channel(channel_id)
				get("/channels/#{channel_id}/posts")
			end

			def search_team_posts(team_id, terms, is_or_search = false)
				post("/teams/#{team_id}/posts/search", :body => {
					:terms => terms,
					:is_or_search => is_or_search
				}.to_json)
			end

			def pin_post(post_id)
				post("/posts/#{post_id}/pin")
			end

			def unpin_post(post_id)
				post("/posts/#{post_id}/unpin")
			end

			def perform_post_action(post_id, action_id)
				post("/posts/#{post_id}/actions/#{action_id}")
			end
		end
	end
end
