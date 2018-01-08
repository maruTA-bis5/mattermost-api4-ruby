require 'json'

module Mattermost
	module Endpoint
		module Emoji

			def create_custom_emoji(image_file, emoji)
				#post("/emoji", emoji.to_json)
				raise NotImplementedError
			end

			def get_custom_emoji_list(max = 60)
				get("/emoji?per_page=#{max}")
			end

			def get_custom_emoji(emoji_id)
				get("/emoji/#{emoji_id}")
			end

			def delete_custom_emoji(emoji_id)
				delete("/emoji/#{emoji_id}")
			end

			def get_custom_emoji_image(emoji_id, file_name)
				File.open(file_name, "w") do |file|
					file.binmode
					get(get_custom_emoji_image_url(emoji_id), stream_body: true) do |fragment|
						file.write(fragment)
					end
				end
			end

			def get_custom_emoji_image_url(emoji_id)
				"/emoji/#{emoji_id}/image"
			end
		end
	end
end
