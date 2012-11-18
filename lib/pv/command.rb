require 'thor'
require 'active_support/all'

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
      run "less -R /tmp/story-#{sha}"
      run "rm -rf /tmp/story-#{sha}"
    end

    desc "edit STORY_ID STATUS", "Edit a story's status on this project."
    #method_option :message, default: "", alias: 'm'
    def edit story_id, status
      story = Story.find story_id
      unless story.update(status)
        run "Error: Story did not update."
      end
    end

    %w(start finish deliver accept reject restart).each do |status|
      desc "#{status} STORY_ID", "#{status.titleize} a story on this project."
      define_method(status) do |story_id|
        edit(story_id, "#{status}ed")
      end
    end

    desc :help, "Show all commands"
    def help
      say <<-TEXT

pv: pivotal tracker in the shell

  A simple command-line interface for Pivotal Tracker.
  Configure in ~/.pv:

    username: 'your-username'
    password: 'secret'
    project_id: 123456

  Then use the following commands to manage your project:
TEXT
      say "\n"
      super
    end
  end
end
