require 'thor'
require 'active_support/all'

module Pv
  class Command < Thor
    default_task :log
    desc :log,  "Show every story assigned to you on this project."
    def log
      Pv.tracker.stories.each do |story|
        say "[#{story.id}] #{story.name} < #{story.requested_by} >"
      end
    end

    desc "show STORY_ID", "Show the full text and attributes of a story on this project."
    def show story_id
      Story.find(story_id).render
    end

    desc "edit STORY_ID", "Edit a story's status on this project."
    method_option :status, default: '', alias: 's'
    method_option :message, default: "", alias: 'm'
    def edit story_id
      story = Story.find story_id
      story.update(status: options[:status]) unless options[:status].blank?
      story.comment! options[:message] unless options[:message].blank?
    end

    %w(start finish deliver accept reject restart).each do |status|
      desc "#{status} STORY_ID", "#{status.titleize} a story on this project."
      define_method(status) do |story_id|
        options[:status] = status
        edit(story_id)
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
