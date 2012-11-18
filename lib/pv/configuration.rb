require 'yaml'

module Pv
  class Configuration
    attr_reader :username, :password, :attributes

    def initialize
      @path = File.expand_path "~/.pv"
      @attributes = YAML::load_file @path
      @username = @attributes['username']
      @password = @attributes['password']
    end

    def present?
      File.exists? @path
    end
  end
end
