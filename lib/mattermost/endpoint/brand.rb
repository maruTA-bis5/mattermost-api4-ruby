require 'json'

module Mattermost
	module Endpoint
		module Brand

			def get_brand_image(file_name)
				File.open(file_name, "w") do |file|
					file.binmode
					get(get_brand_image_url(), stream_body: true) do |fragment|
						file.write(fragment)
					end
				end
			end

			def get_brand_image_url
				"/brand/image"
			end

			def upload_brand_image(image_file)
				#post("/brand/image", image_file)
				raise NotImplementedError
			end

		end
	end
end
