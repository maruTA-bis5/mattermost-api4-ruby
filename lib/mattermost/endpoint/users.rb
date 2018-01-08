module Mattermost
	module Endpoint
		module Users
			def getMe
				get("/users/me")
			end
		end
	end
end
