require 'pv/configuration'

module Pv
  describe Configuration do
    before do
      if File.exists? File.expand_path("~/.pv")
        `cp ~/.pv ~/.pv.safe`
      end

      `cp spec/fixtures/pv.yml ~/.pv`
    end

    subject { Pv::Configuration.new }

    it "reads from ~/.pv YAML" do
      subject.should be_present
      subject.attributes.should_not be_empty
      subject.attributes.count.should == 4
    end

    it "parses a username" do
      subject.username.should == "johndoe"
    end

    it "parses a password" do
      subject.password.should == "password"
    end

    it "parses a full name" do
      subject.name.should == "John Doe"
    end

    it "parses a project id into a number" do
      subject.project_id.should == 123456
    end

    after do
      if File.exists? File.expand_path("~/.pv.safe")
        `cp ~/.pv.safe ~/.pv`
      end
    end
  end
end
