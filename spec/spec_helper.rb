require 'bundler/setup'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec/its'

require 'single_cov'

require 'manageo'

ENV['MANAGEO_KEY']  ||= '*************'

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.formatter = :documentation
  config.tty = true
  # config.expect_with(:rspec) { |c| c.syntax = :should }
end
