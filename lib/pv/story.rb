module Pv
  class Story
    attr_accessor :story_type, :requested_by, :owned_by, :current_state,
                  :name, :description, :estimate, :id
    attr_reader :pivotal_story

    def initialize from_pivotal_story
      @pivotal_story = from_pivotal_story
      %w(id story_type requested_by owned_by current_state name description estimate).each do |attr|
        self.send "#{attr}=", from_pivotal_story.send(attr)
      end
    end

    def self.find by_id
      new Pv.tracker.stories.select { |s| s.id == by_id.to_i }.first
    end

    # Render this Story in plain text.
    def render
      source = IO.read "#{Pv.root}/lib/templates/story.txt.erb"
      template = ERB.new(source)
      template.result(binding)
    end

    def update(status)
      @pivotal_story.update(current_state: status)
    end
  end
end
