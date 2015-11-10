$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nibo'

require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
