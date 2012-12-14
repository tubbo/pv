require 'core_ext/string'

describe String do
  describe "titleization" do
    it "capitalizes each word" do
      subject = "not yet started"

      subject.titleize.should == "Not Yet Started"
    end

    it "returns a blank string if that's what was given" do
      subject = " "

      subject.titleize.should be_blank
    end

    it "does nothing with non alphanumerics" do
      subject = "^@#%@#^@%#^@#%&"

      subject.titleize.should == subject
    end
  end

  describe "checking for blankness" do
    it "returns 'true' when no data is present" do
      subject = ""

      subject.should be_blank
    end

    it "returns 'false' if characters exist" do
      subject = "1"

      subject.should_not be_blank
    end

    it "returns 'true' if spaces exist" do
      subject = " "

      subject.should_not be_blank
    end
  end
end
