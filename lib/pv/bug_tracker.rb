require 'pivotal_tracker'

module Pv
  class BugTracker
    def initialize with_username, and_password
      PivotalTracker::Client.use_ssl = true
      @token = PivotalTracker::Client.token(with_username, and_password)
    end

    def connected?
      @token != nil
    end

    def stories for_project_id, and_full_name
      project = PivotalTracker::Project.all.select { |p| p.id == for_project_id }.first
      project.stories.all(owned_by: and_full_name)
    end
  end
end
