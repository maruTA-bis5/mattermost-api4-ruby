require 'json'

module Mattermost
	module Endpoint
		module Files

			def upload_file(file, channel_id)
				#post("/files, file)
				raise NotImplementedError
			end

			def get_file(file_id, file_name)
				File.open(file_name, "w") do |file|
					file.binmode
					get(get_file_url(file_id), stream_body: true) do |fragment|
						file.write(fragment)
					end
				end
			end

			def get_file_url(file_id)
				"/files/#{file_id}"
			end

			def get_file_thumbnail(file_id, file_name)
				File.open(file_name, "w") do |file|
					file.binmode
					get(get_file_thumbnail_url(file_id), stream_body: true) do |fragment|
						file.write(fragment)
					end
				end
			end

			def get_file_thumbnail_url(file_id)
				"/files/#{file_id}/thumbnail"
			end

			def get_file_preview(file_id, file_name)
				File.open(file_name, "w") do |file|
					file.binmode
					get(get_file_preview_url(file_id), stream_body: true) do |fragment|
						file.write(fragment)
					end
				end
			end

			def get_file_preview_url(file_id)
				"/files/#{file_id}/preview"
			end

			def get_public_file_link(file_id)
				get("/files/#{file_id}/link")
			end

			def get_metadata_for_file(file_id)
				get("/files/#{file_id}/info")
			end
		end
	end
end
