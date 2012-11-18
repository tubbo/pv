module Pv
  class Story
    attr_accessor :story_type, :requested_by, :owned_by, :current_state,
                  :name, :description, :estimate, :id

    def initialize from_pivotal_story
      %w(id story_type requested_by owned_by current_state name description estimate).each do |attr|
        self.send "#{attr}=", from_pivotal_story.send(attr)
      end
    end

    def self.find by_id
      new Pv.tracker.stories.find(by_id).first
    end

    # Render this Story in plain text.
    def render
      source = IO.read "./lib/templates/story.txt.erb"
      template = ERB.new(source)
      template.result(binding)
    end
  end
end
