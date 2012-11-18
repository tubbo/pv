require 'pivotal_tracker'

module Pv
  class BugTracker
    attr_reader :username, :password, :token

    def initialize with_username=nil, and_password=nil
      @username = with_username || Pv.config.username
      @password = and_password  || Pv.config.password
      @token = PivotalTracker::Client.token(username, password)

      PivotalTracker::Client.use_ssl = true
    end

    def connected?
      @token != nil
    end

    def stories for_project_id=nil, and_full_name=nil
      project_id = for_project_id || Pv.config.project_id
      user = and_full_name || Pv.config.name

      project = PivotalTracker::Project.all.select { |p| p.id == project_id }.first
      project.stories.all(owned_by: user)
    end
  end
end
