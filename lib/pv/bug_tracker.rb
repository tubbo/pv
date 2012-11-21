require 'pivotal_tracker'

module Pv
  class BugTracker
    attr_reader :username, :password, :token, :project

    # Connect to Pivotal Tracker
    def initialize with_username=nil, and_password=nil, and_project_id=nil
      @username = with_username || Pv.config.username
      @password = and_password  || Pv.config.password
      @token = PivotalTracker::Client.token(username, password)

      @project = begin
        project_id = and_project_id || Pv.config.project_id
        PivotalTracker::Project.all.select { |p| p.id == project_id }.first if @token.present?
      end

      PivotalTracker::Client.use_ssl = true
    end

    # Test whether we are connected.
    def connected?
      @token.present?
    end

    # Find stories filtered by this username.
    def stories by_user_name=nil
      user = by_user_name || Pv.config.name
      @project.stories.all(owned_by: user).reject { |s| s.current_state =~ /accepted|delivered/ }
    end
  end
end
