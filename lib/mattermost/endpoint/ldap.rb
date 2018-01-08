require 'json'

module Mattermost
	module Endpoint
		module LDAP

			def sync_with_ldap
				post("/ldap/sync")
			end

			def test_ldap_configuration
				post("/ldap/test")
			end

		end
	end
end
