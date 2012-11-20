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
      subject.attributes.count.should == 3
    end

    it "parses a username" do
      subject.username.should == "john@doe.com"
    end

    it "parses a password" do
      subject.password.should == "password"
    end

    after do
      if File.exists? File.expand_path("~/.pv.safe")
        `cp ~/.pv.safe ~/.pv`
      end
    end
  end
end
