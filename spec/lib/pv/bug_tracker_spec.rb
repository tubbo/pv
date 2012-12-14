require 'spec_helper'
require 'pv/bug_tracker'

module Pv
  describe BugTracker do
    subject do
      VCR.use_cassette(:pivotal_client_connection) { Pv::BugTracker.new }
    end

    it "connects to pivotal tracker" do
      subject.should be_connected
    end

    it "gathers the list of stories this user has to accomplish" do
      VCR.use_cassette :pivotal_project_stories_search do
        subject.stories("Tom Scott").should_not be_empty
      end
    end

    it "creates a new story on the pivotal api"

    it "updates an existing story on the pivotal api"
  end
end
