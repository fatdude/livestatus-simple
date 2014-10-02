require 'bundler/setup'
Bundler.setup

require 'livestatus-simple'
require 'dotenv'

Dotenv.load( File.expand_path(__FILE__ + '/../.localenv'),
             File.expand_path(__FILE__ + '/../.env'))

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  # config.filter_run :focus

  config.order = 'random'
end
