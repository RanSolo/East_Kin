json.extract! job, :id, :status, :dependant, :created_at, :updated_at
json.url job_url(job, format: :json)