require_relative 'cheese'
require_relative 'future'
require_relative 'cupcake'

class App

  attr_accessor :env, :path

  def initialize(env)
    @env = env
    @path = env["PATH_INFO"]
    @num = env["REQUEST_PATH"].sub(/\/\w+[|\/]/, "").to_i
    @num = 1 if @num.zero?
  end

  def response
    if path.start_with?("/lipsums")
      lipsums
    elsif path.start_with?("/cheese")
      output(Cheese)
    elsif path.start_with?("/future")
      output(Future)
    elsif path.start_with?("/cupcake")
      output(Cupcake)
    elsif path.start_with?("/current_time")
      time
    else
      f_o_f
    end
  end

  def output(lip)
      ['200', headers, lip.call(@num)]
  end

  def time
    ['200', headers, ["#{Time.now}"]]
  end

  def lipsums
    ['200', headers, ["Pick one of the following: Cheese, Future, or Cupcake"]]
  end

  def f_o_f
    ['404', headers, ["These are not the droids you were looking for"]]
  end

  def headers
    {'Content-Type' => 'text/html'}
  end

  def self.call(env)
    new(env).response
  end



end
