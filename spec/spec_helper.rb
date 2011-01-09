require 'rubygems'
require 'rspec'
require 'webrat'
require 'rack/test'

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__))

require 'rack/analytics'

require 'spec/support/dummy_app'
require 'spec/support/redis_mock'

RSpec.configure do |config|
  config.include Webrat::Matchers
  config.include Webrat::Methods
  config.include Rack::Test::Methods

  Webrat.configure do |c|
    c.mode = :rack
  end

  def app
    Rack::Builder.new do
      use Rack::Analytics::Application, :redis => db
      run DummyApp
    end
  end

  def db
    $redis ||= RedisMock.new
  end
end
