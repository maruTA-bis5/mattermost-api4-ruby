require 'json'

module Mattermost
	module Endpoint
		module Users
			def getMe
				get_user("me")
			end

			def create_user(user)
				post("/users", :body => user.to_json)
			end

			def get_users(options = {}, max = 60)
				query = ""

				query = "#{query}&in_team=#{options[:in_team]}" if options.key? :in_team
				query = "#{query}&not_in_team=#{options[:not_in_team]}" if options.key? :not_in_team

				query = "#{query}&in_channel=#{options[:in_channel]}" if options.key? :in_channel
				query = "#{query}&not_in_channel#{options[:not_in_channel]}" if options.key? :not_in_channel
	
				query = "#{query}&without_team=#{options[:without_team]}" if options.key? :without_team

				query = "#{query}&sort=#{options[:sort]}" if options.key? :sort

				get("/users?per_page=#{max}#{query}")
			end

			def get_users_by_ids(user_ids = [])
				post("/users/ids", :body => JSON.generate(user_ids))
			end

			def get_users_by_usernames(usernames = [])
				post("/users/usernames", :body => JSON.generate(usernames))
			end

			def search_users(term, options = {})
				criteria = options.dup
				criteria[:term] = term
				post("/users/search", :body => criteria.to_json)
			end

			def autocomplete_users(name, params = {})
				query = "?name=#{name}"
				query = "#{query}&team_id=#{params[:team_id]}" if params.key? :team_id
				query = "#{query}&channel_id=#{params[:channel_id]}" if params.key? :channel_id

				get("/users/autocomplete#{query}")
			end

			def get_user(user_id)
				get("/users/#{user_id}")
			end

			def update_user(user_id, user)
				post("/users/#{user_id}", :body => user.to_json)
			end

			def deativate_user_account(user_id)
				delete("/users/#{user_id}")
			end

			def patch_user(user_id, patch = {})
				put("/users/#{user_id}/patch", :body => patch.to_json)
			end

			def update_user_roles(user_id, roles)
				put("/users/#{user_id}/roles", roles)
			end

			def update_user_active_status(user_id, active)
				put("/users/#{user_id}/active", :body => {
					:active => active
				}.to_json)
			end

			def get_user_profile_image(user_id, file_name)
				File.open(file_name, "w") do |file|
					file.binmode
					get(get_user_profile_image_url(user_id), stream_body: true) do |fragment|
						file.write(fragment)
					end
				end
			end

			def get_user_profile_image_url(user_id)
				"/users/#{user_id}/image"
			end

			def set_user_profile_image(user_id, image)
				#post("/users/#{user_id}/image", image)
				raise NotImplementedError
			end

			def get_user_by_username(username)
				get("/users/username/#{username}")
			end

			def reset_password(code, new_password)
				post("/users/password/reset", :body => {
					:code => code,
					:new_password => new_password
				}.to_json)
			end

			def update_user_mfa(user_id, activate, code = nil)
				params = {:activate => activate}
				params[:code] = code if code != nil
				put("/users/#{user_id}/mfa", params.to_json)
			end

			def generate_mfa_secret(user_id)
				post("/users/#{user_id}/mfa/generate")
			end

			def check_mfa(login_id)
				post("/users/mfa", :body => {:login_id => login_id}.to_json)
			end

			def update_user_password(user_id, current_password, new_password)
				put("/users/#{user_id}/password", :body => {
					:current_password => current_password,
					:new_password => new_password
				}.to_json)
			end

			def send_password_reset_email(email)
				post("/users/password/reset/send", :body => {:email => email}.to_json)
			end

			def get_user_by_email(email)
				get("/users/email/#{email}")
			end

			def get_user_sessions(user_id)
				get("/users/#{user_id}/sessions")
			end

			def revoke_user_session(user_id, session_id)
				post("/users/#{user_id}/sessions/revoke", :body => {:session_id => session_id}.to_json)
			end

			def revoke_all_active_session_for_user(user_id)
				post("/users/#{user_id}/sessions/revoke/all")
			end

			def attach_mobile_device(device_id)
				put("/users/sessions/device", :body => {:device_id => device_id}.to_json)
			end

			def get_user_audits(user_id)
				get("/users/#{user_id}/audits")
			end

			def verify_user_email(token)
				post("/users/email/verify", :body => {:token => token}.to_json)
			end

			def send_verification_email(email)
				post("/users/email/verify/send", :body => {:email => email}.to_json)
			end

			def switch_login_method(params)
				post("/users/login/switch", :body => params.to_json)
			end

			def create_user_access_token(user_id, description)
				post("/users/#{user_id}/tokens", :body => {:description => description}.to_json)
			end

			def get_user_access_tokens(user_id, max = 60)
				get("/users/#{user_id}/tokens?per_page=#{max}")
			end

			def revoke_user_access_token(token)
				post("/users/tokens/revoke", :body => {:token => token}.to_json)
			end

			def get_user_access_token(token)
				get("/users/tokens/#{token}")
			end

			def disable_personal_access_token(token)
				post("/users/tokens/disable", :body => {:token => token}.to_json)
			end

			def enable_personal_access_token(token)
				post("/users/tokens/enable", :body => {:token => token}.to_json)
			end
		end
	end
end
