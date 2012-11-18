require 'yaml'

module Pv
  class Configuration
    attr_reader :username, :password, :attributes, :project_id, :name

    def initialize
      @path = File.expand_path "~/.pv"
      @attributes = YAML::load_file @path
      @username = @attributes['username']
      @password = @attributes['password']
      @project_id = @attributes['project_id']
      @name = @attributes['name']
    end

    def present?
      File.exists? @path
    end
  end
end
