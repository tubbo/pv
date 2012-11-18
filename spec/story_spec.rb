require 'spec_helper'
require 'pv/story'

module Pv
  describe Story do
    subject do
      VCR.use_cassette :pivotal_find_story do
        Story.find(39415599)
      end
    end

    it "can be found by id" do
      subject.should be_present
    end

    it "can be rendered to plain text" do
      subject.render.should_not be_blank
      subject.render.should =~ /Assigned To:/
    end
  end
end
