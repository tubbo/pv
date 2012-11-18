require 'spec_helper'
require 'pv/bug_tracker'

module Pv
  describe BugTracker do
    subject do
      VCR.use_cassette :pivotal_client_connection do
        Pv::BugTracker.new("john@doe.com", "password")
      end
    end

    it "connects to pivotal tracker" do
      subject.should be_connected
    end

    it "gathers the list of stories this user has to accomplish" do
      VCR.use_cassette :pivotal_project_stories_search do
        subject.stories(461255, "Tom Scott").should_not be_empty
      end
    end
  end
end
