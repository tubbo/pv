require 'core_ext/object'

describe Object do
  subject { Object.new }

  it "should be present when instantiated" do
    subject.should be_present
  end

  it "should not be present when nil" do
    nil.should_not be_present
  end
end
