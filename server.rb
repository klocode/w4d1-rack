require 'rack'
require_relative 'app'

app = App

# app = Proc.new do |env|
#   # Finds the num of paragraphs requested, or sets it to 1
  # num = env["REQUEST_PATH"].sub(/\/\w+[|\/]/, "")
  # num = 1 if num.to_i.zero?
  #
  # path = env["PATH_INFO"]
  # headers = {'Content-Type' => 'text/html'}
#
#   if path.start_with?("/lipsums")
#     ['200', headers, ["pick one of the following: cheese, future, or cupcake"]]
#   elsif path.start_with?("/cheese")
#     ['200', headers, Cheese.call(num)]
#   elsif path.start_with?("/future")
#     ['200', headers, Future.call(num)]
#   elsif path.start_with?("/cupcake")
#     ['200', headers, Cupcake.call(num)]
#   else
#     ['404', headers, ["These are not the droids you were looking for"]]
#   end
#
# end

Rack::Handler::WEBrick.run app
