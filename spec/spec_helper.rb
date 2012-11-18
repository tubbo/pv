require 'rubygems'
require 'bundler'

Bundler.require :default

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.stub_with :webmock
end
