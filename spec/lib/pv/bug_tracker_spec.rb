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
        subject.stories.where(owned_by: "Tom Scott").should_not be_empty
      end
    end

    it "creates a new story on the pivotal api" do
      VCR.use_cassette :pivotal_project_stories_create do
        story = subject.stories.create(name: "Test", type: :bug, description: "Test body.")

        story.should be_present
      end
    end

    it "updates an existing story on the pivotal api" do
      VCR.use_cassette :pivotal_project_stories_update do
        story = subject.stories.find(123456)

        story.should be_present
      end
    end
  end
end
