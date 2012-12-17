# A collection of Story objects, accessed ActiveRecord-style.
module Pv
  class Stories
    def initialize from_project
      @project = from_project
    end

    # Return a new collection of Stories for the given +PivotalTracker::Project+
    def self.from project
      new project
    end

    # Find a given story by ID. Returns +nil+ when none are found, or a +Pv::Story+
    # when found.
    def find by_id
      stories = where(id: by_id)

      if stories.empty?
        nil
      else
        Story.new stories.first
      end
    end

    # Return a collection of all Stories that match the given query. Always returns a collection
    # of some kind.
    def where has_options={}
      @project.stories.all(has_options).reject { |s| s.current_state =~ /accepted|delivered/ }
    end

    # Create a new story for the given Project on PivotalTracker. Called from the Story class when
    # saving to actually do the API call.
    def create with_options={}
      new Pv.tracker.stories.create with_options
    end
  end
end
