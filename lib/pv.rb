require 'core_ext/string'
require 'core_ext/object'

require 'pv/configuration'
require 'pv/command'
require 'pv/version'
require 'pv/bug_tracker'
require 'pv/story'

module Pv
  # Load YAML configuration
  def self.config
    @config ||= Pv::Configuration.new
  end

  # Connect to Pivotal Tracker
  def self.tracker
    @tracker ||= Pv::BugTracker.new
  end

  # Find where this code lives
  def self.root
    @root ||= begin
      spec = Gem::Specification.find_by_name 'pv'
      spec.gem_dir
    end
  end
end
