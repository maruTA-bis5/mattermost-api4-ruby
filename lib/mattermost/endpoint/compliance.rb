require 'json'

module Mattermost
	module Endpoint
		module Compliance

			def create_compliance_report
				post("/compliance/reports")
			end

			def get_compliance_reports(max = 60)
				get("/compliance/reports?per_page=#{max}")
			end

			def get_compliance_report(report_id)
				get("/compliance/reports/#{report_id}")
			end

			def download_compliance_report(report_id, file_name)
				File.open(file_name, "w") do |file|
					file.binmode
					get(download_compliance_report_url(report_id), stream_body: true) do |fragment|
						file.write(fragment)
					end
				end
			end

			def download_compliance_report_url(report_id)
				"/compliance/reports/#{report_id}/download"
			end
		end
	end
end
