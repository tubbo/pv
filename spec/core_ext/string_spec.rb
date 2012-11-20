require 'pv/core_ext/string'

module Pv
  describe String do
    subject { "started" }

    it "should replicate ActiveSupport::String.titleize" do
      subject.titleize.should == "Started"
    end
  end
end
