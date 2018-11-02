require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def set_up
    @user = users(:wang1)
    @micropost = @use.micropost.build(content:"lorem ipsum")
  end

  test "should be valid" do 
    assert @micropost.valid?

  end 
  
   test "user id should be present" do 
     @micropost.user_id = nil
     assert_not @micropost.valid?
  end  
  
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
    end




end
