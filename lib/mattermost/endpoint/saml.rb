require 'json'

module Mattermost
	module Endpoint
		module SAML

			def get_saml_metadata
				get("/saml/metadata")
			end

			def upload_idp_certificate(certificate)
				#post("saml/certifiate/idp", certificate)
				raise NotImplementedError
			end

			def remove_idp_certificate
				delete("/saml/certificate/idp")
			end

			def upload_public_certificate(certificate)
				#post("/saml/certificate/public", certificate)
				raise NotImplementedError
			end

			def remove_public_certificate
				delete("/saml/certificate/public")
			end

			def upload_private_key(key)
				#post("/saml/certificate/private", key)
				raise NotImplementedError
			end

			def remove_private_key
				delete("/saml/certificate/private")
			end

			def get_certificate_status
				get("/saml/certificate/status")
			end
		end
	end
end
