require 'minitest/autorun'
require 'minitest/pride'
require "rack/test"
require_relative 'server'

class ServerTest < MiniTest::Test

  include Rack::Test::Methods

end
