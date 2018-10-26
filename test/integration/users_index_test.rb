require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:wang1)
  end

  test "index including pagination" do 
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page:1).each do |f|
      assert_select 'a[href=?]', user_path(f), text:f.name
    end
  end  
end
