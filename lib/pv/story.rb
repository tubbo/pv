module Pv
  class Story
    attr_accessor :type, :requested_by, :owned_by, :status, :name, :description

    def initialize with_options={}
      %w(type requested_by owned_by status name description).each do |attr|
        self.send "#{attr}=", with_options[attr]
      end
    end

    def self.find by_id
      new Pv.tracker.stories.find(by_id)
    end

    # Render this Story in plain text.
    def render
      source = IO.read "./lib/templates/story.txt.erb"
      template = ERB.new(source)
      template.result(self)
    end
  end
end
