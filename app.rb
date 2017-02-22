require_relative 'cheese'
require_relative 'future'
require_relative 'cupcake'
require_relative 'timezones'

class App
  include Timezones

  attr_accessor :env, :path

  def initialize(env)
    @env = env
    @path = env["PATH_INFO"]
    @num = env["PATH_INFO"].sub(/\/\w+[|\/]/, "").to_i
    @num = 1 if @num.zero?
    @timezone = env["PATH_INFO"].sub(/\w+[|\/]+\w+[|\/]/, "").to_s
  end

  # How do I get it to fail if I have a PATH such as "/cheese/sdfouahfuoa"
  def response
    if path.start_with?("/lipsums")
      lipsums
    elsif path.start_with?("/cheese")
      output(Cheese)
    elsif path.start_with?("/future")
      output(Future)
    elsif path.start_with?("/cupcake")
      output(Cupcake)
    elsif path.start_with?("/current_time") && path.end_with?("/#{@timezone}")
      time_and_zone
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
    ['200', headers, ["#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}"]]
  end

  def time_and_zone
    ['200', headers, ["#{Time.current}"]]
  end

  def lipsums
    ['200', headers, ["Pick one of the following: Cheese, Future, or Cupcake"]]
  end

  def f_o_f
    ['404', headers, ["We're sorry. We couldn't do that."]]
  end

  def headers
    {'Content-Type' => 'text/html'}
  end

  def self.call(env)
    new(env).response
  end



end
