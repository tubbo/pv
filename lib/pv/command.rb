require 'thor'

module Pv
  class Command < Thor
    include Thor::Actions

    default_task :log
    desc :log,  "Show every story assigned to you on this project."
    def log
      Pv.tracker.stories.each do |story|
        id = set_color "#{story.id}", Thor::Shell::Color::YELLOW
        author = set_color story.requested_by, Thor::Shell::Color::WHITE

        say "* #{id} #{story.name} #{author}"
      end
    end

    desc "show STORY_ID", "Show the full text and attributes of a story on this project."
    def show story_id
      sha = Digest::HMAC.hexdigest story_id.to_s, Time.now.to_s, Digest::SHA1
      File.write "/tmp/story-#{sha}", Story.find(story_id).render
      system "$PAGER /tmp/story-#{sha}"
      system "rm -rf /tmp/story-#{sha}"
    end

    desc "edit STORY_ID STATUS", "Edit a story's status on this project."
    #method_option :message, default: "", alias: 'm'
    def edit story_id, status
      story = Story.find(story_id) or raise "Error: Story not found"

      if story.update(status)
        say "#{status.titleize} ##{story_id}"
      else
        say "Error: Story did not update."
      end
    end

    %w(start finish deliver accept reject restart).each do |status|
      desc "#{status} STORY_ID", "#{status.titleize} a story on this project."
      define_method(status) do |story_id|
        edit(story_id, "#{status}ed")
      end
    end

    desc "create {bug|feature|chore} NAME", "Create a new story on this project"
    method_option :assign_to
    def create type, name
      with_attributes = options.merge(story_type: type, name: name)
      story = Story.create with_attributes

      if story.saved?
        say "Created #{type.titleize} ##{story.id}: '#{name}'"
      else
        say "Error saving #{type} with '#{name}'"
      end
    end

    desc :help, "Show all commands"
    def help
      say IO.read("#{Pv.root}/lib/templates/help.txt")
      super
    end

    desc "open STORY_ID", "Open this Pivotal story in a browser"
    def open story_id
      run "open https://www.pivotaltracker.com/story/show/#{story_id}"
    end
  end
end
