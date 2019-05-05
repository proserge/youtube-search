# frozen_string_literal: true

require 'test_helper'

class YoutubeSearchControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get youtube_search_show_url
    assert_response :success
  end
end
