require 'core_ext/object'

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

    # Find a story by its Pivotal ID
    def self.find by_id
      new Pv.tracker.stories.select { |s| s.id == by_id.to_i }.first
    end

    # Build a new Pivotal story with the given attributes.
    def self.create from_attributes={}
      new Pv.tracker.project.stories.create from_attributes
    end

    # Render this Story in plain text.
    def render
      source = IO.read "#{Pv.root}/lib/templates/story.txt.erb"
      template = ERB.new(source)
      template.result(binding)
    end

    # This story is "in progress" if its code has not left
    # the dev machine, or is on stage and hasn't been pushed
    # to production yet.
    def in_progress?
      if current_state =~ /started|finished/
        true
      else
        false
      end
    end

    # Update the current status of a Story.
    def update(status)
      @pivotal_story.update(current_state: status)
    end

    # Test if this story has been saved on Pivotal.
    def saved?
      Pv.tracker.project.stories.find(id).present?
    end

    # Test if this story has any errors.
    def valid?
      errors.any?
    end

    # Show all errors related to this story.
    def errors
      @pivotal_story.errors
    end
  end
end
