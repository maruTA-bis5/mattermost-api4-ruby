require 'json'

module Mattermost
	module Endpoint
		module Jobs

			def get_jobs(max = 60)
				get("/jobs?per_page=#{max}")
			end

			def create_job(job)
				post("/jobs", :body => job.to_json)
			end

			def get_job(job_id)
				get("/jobs/#{job_id}")
			end

			def cancel_job(job_id)
				post("/jobs/#{job_id}/cancel")
			end

			def get_jobs_of_type(type, max = 60)
				get("/jobs/type/#{type}?per_page=#{max}")
			end
		end
	end
end
