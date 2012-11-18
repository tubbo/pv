require 'pv/configuration'

module Pv
  describe Configuration do
    before do
      `cp spec/fixtures/pv.yml ~/.pv` unless File.exists? "~/.pv"
    end

    subject { Pv::Configuration.new }

    it "reads from ~/.pv YAML" do
      subject.should be_present
      subject.attributes.should_not be_empty
      subject.attributes.count.should == 2
    end

    it "parses a username" do
      subject.username.should == "john@doe.com"
    end

    it "parses a password" do
      subject.password.should == "password"
    end
  end
end
