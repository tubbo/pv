require 'rubygems'
require 'bundler' and Bundler.setup
require 'pv'
require 'pivotal-tracker'
require 'thor'
require 'nokogiri-happymapper'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end
