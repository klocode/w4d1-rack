require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require_relative 'app'

class AppTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    App
  end

  def setup
    @cheese = "I love cheese, especially cow cheese slices. Cheese on toast halloumi cheesy feet cauliflower cheese cheesy grin hard cheese pecorino when the cheese comes out everybody's happy. Fromage macaroni cheese port-salut pecorino bocconcini melted cheese the big cheese parmesan. Brie manchego cheddar cauliflower cheese macaroni cheese cheese strings babybel cut the cheese. Caerphilly cheese strings edam who moved my cheese fromage lancashire cheese triangles boursin. Dolcelatte gouda cauliflower cheese cut the cheese smelly cheese.<br>"
    @cupcake = "Candy biscuit chocolate bar cookie sesame snaps cake cookie toffee. Cookie dessert tootsie roll gummi bears. Chocolate bar soufflé pastry soufflé dessert. Muffin gingerbread fruitcake. Jelly beans wafer cake cheesecake. Donut cake cake croissant chupa chups apple pie oat cake. Gingerbread liquorice sweet roll powder lemon drops biscuit tiramisu sugar plum caramels. Cupcake cupcake cupcake jelly danish danish tiramisu carrot cake. Jelly gummi bears sesame snaps jelly muffin dragée croissant ice cream cake. Biscuit tootsie roll gummi bears chocolate chupa chups chocolate cake bonbon. Cupcake fruitcake dessert dragée cake chocolate bar chocolate cake. Tart jelly-o brownie tootsie roll croissant danish muffin bonbon.<br>"
    @future ="Marty, I'm sorry, but the only power source capable of generating one point twenty-one gigawatts of electricity is a bolt of lightning. Yeah I know, If you put your mind to it you could accomplish anything. I don't wanna know your name. I don't wanna know anything anything about you. Cause, George, she wants to go to the dance with you, she just doesn't know it yet. That's why we got to show her that you, George McFly, are a fighter. You're somebody who's gonna stand up for yourself, someone who's gonna protect her. Listen, Doc, you know there's something I haven't told you about the night we made that tape. Don't pay any attention to him, he's in one of his moods. Sam, quit fiddling with that thing, come in here to dinner. Now let's see, you already know Lorraine, this is Milton, this is Sally, that's Toby, and over there in the playpen is little baby Joey.<br>"
  end

  def test_lipsums
    get "/lipsums"
    assert last_response.ok?
    assert_equal "Pick one of the following: Cheese, Future, or Cupcake", last_response.body
  end

  def test_an_error
    get "/skdfbaiufa"
    refute last_response.ok?
    assert_equal 404, last_response.status
    assert_equal "We're sorry. We couldn't do that.", last_response.body
  end

  def test_cheese
    get "/cheese"
    assert last_response.ok?
    assert_equal @cheese, last_response.body

    get "/cheese/4"
    assert last_response.ok?
    assert_equal @cheese*4, last_response.body
  end

  def test_future
    get "/future"
    assert last_response.ok?
    assert_equal @future, last_response.body

    get "/future/4"
    assert last_response.ok?
    assert_equal @future*4, last_response.body
  end

  def test_cupcake
    get "/cupcake"
    assert last_response.ok?
    assert_equal @cupcake, last_response.body

    get "/cupcake/4"
    assert last_response.ok?
    assert_equal @cupcake*4, last_response.body
  end

  def test_current_time
    get "/current_time"
    assert last_response.ok?
    assert_equal Time.now.strftime("%Y-%m-%d %H:%M:%S"), last_response.body
  end

end
