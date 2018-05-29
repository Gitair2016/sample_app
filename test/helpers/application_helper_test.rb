require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
        assert_equal full_title,    "Ruby on Rails Tutorial Sample App","#{@base_title}"
        assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App","Help | #{@base_title}"
  end
end
