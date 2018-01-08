require 'json'

module Mattermost
	module Endpoint
		module Teams
			def create_team(name, display_name, type)
				post("/teams", :body => {
					:name => name,
					:display_name => display_name,
					:type => type
				}.to_json)
			end

			def get_teams(max = 60)
				get("/teams?per_page=#{max}")
			end

			def get_team(team_id)
				get("/teams/#{team_id}")
			end

			def update_team(team_id, team = {})
				put("/teams/#{team_id}", :body => team.to_json)
			end

			def delete_team(team_id)
				delete("/teams/#{team_id}")
			end

			def patch_team(team_id, patch = {})
				put("/teams/#{team_id}/patch", :body => patch.to_json)
			end

			def get_team_by_name(team_name)
				get("/teams/name/#{team_name}")
			end

			def search_teams(term)
				post("/teams/search", :body => {:term => term}.to_json)
			end

			def team_exists?(team_name)
				get("/teams/name/#{team_name}/exists")
			end

			def get_teams_for_user(user_id)
				get("/users/#{user_id}/teams")
			end

			def get_team_members(team_id)
				get("/teams/#{team_id}/members")
			end

			def add_user_to_team(team_id, user_id, roles)
				post("/teams/#{team_id}/members", :body => {
					:team_id => team_id,
					:user_id => user_id,
					:roles => roles
				}.to_json)
			end

			def add_user_to_team_from_invite(hash, data, invite_id)
				post("/teams/members/invoite?hash=#{hash}&data=#{data}&invite_id=#{invite_id}")
			end

			def add_users_to_team(team_id, users)
				post("/teams/#{team_id}/members/batch", :body => users.to_json)
			end

			def get_team_members_for_user(user_id)
				get("/users/#{user_id}/teams/members")
			end

			def get_team_member(team_id, user_id)
				get("/teams/#{team_id}/members/#{user_id}")
			end

			def remove_user_from_team(team_id, user_id)
				delete("/teams/#{team_id}/members/#{user_id}")
			end

			def get_team_members_by_ids(team_id, user_ids = [])
				get("/teams/#{team_id}/members/ids", :body => JSON.generate(user_ids))
			end

			def get_team_stats(team_id)
				get("/teams/#{team_id}/stats")
			end

			def update_team_member_role(team_id, user_id, roles)
				put("/teams/#{team_id}/members/#{user_id}/roles", :body => { :roles => roles}.to_json)
			end

			def get_team_unreads(user_id)
				get("/users/#{user_id}/teams/unread")
			end

			def get_unreads_for_team(user_id, team_id)
				get("/users/#{user_id}/teams/#{team_id}/unread")
			end

			def invite_users_by_email(team_id, emails = [])
				post("/teams/#{team_id}/invite/email", :body => JSON.generate(emails))
			end

			# TODO: POST /teams/#{team_id}/import

			def get_invite_info(invite_id)
				get("/teams/invite/#{invite_id}")
			end
		end
	end
end
