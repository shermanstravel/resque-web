require 'rubygems'
require 'bundler/setup'

require 'resque/server'
require 'yaml'

# Our config
config = YAML.load_file( File.expand_path('../resque-web.yml', __FILE__) )

# Setup resque
load ::File.expand_path("#{config['resque']['app_path']}/config/initializers/resque.rb")

# Setup basic auth
Resque::Server.use Rack::Auth::Basic do |username, password|
  username == config['username'] && password == config['password']
end

use Rack::ShowExceptions
run Resque::Server.new

