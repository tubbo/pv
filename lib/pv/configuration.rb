require 'yaml'

module Pv
  class Configuration
    attr_reader :username, :password, :attributes, :project_id, :name

    def initialize
      @attributes = YAML::load_file from_path
      @username = @attributes['username']
      @password = @attributes['password']
      @project_id = @attributes['project_id']
      @name = @attributes['name']
    end

    def present?
      File.exists? from_path
    end

  private
    def from_path
      File.expand_path yaml_file_location
    end

    def yaml_file_location
      if File.exists? "#{Dir.pwd}/.pv"
        "#{Dir.pwd}/.pv"
      else
        "~/.pv"
      end
    end
  end
end
