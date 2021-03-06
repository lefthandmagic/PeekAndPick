require File.expand_path('../../unit_test_helper', __FILE__)

class YouTubeTest < Test::Unit::TestCase

  def test_https
    result = auto_html('https://www.youtube.com/watch?v=beOgcOu-vQU&feature=player_embedded#!') { youtube }
    assert_equal :video, result["type"]
    assert_equal :youtube, result["provider"]
    assert_not_nil result["youtube_id"]
  end
  
  def test_transform
    result = auto_html('http://www.youtube.com/watch?NR=1&feature=endscreen&v=ndtno2tBGbo') { youtube }
    assert_equal :video, result["type"]
    assert_equal :youtube, result["provider"]
    assert_not_nil result["youtube_id"]
  end

  def test_transform2
    result = auto_html('http://www.youtube.com/watch?v=7rdQxsbE_XQ&feature=related') { youtube }
    assert_equal :video, result["type"]
    assert_equal :youtube, result["provider"]
    assert_not_nil result["youtube_id"]
  end

  def test_transform3
    result = auto_html('http://www.youtube.com/watch?v=SK4A7JvO7jE&feature=g-all-u&context=G26c894eFAAAAAAAAAAA') { youtube }
    assert_equal :video, result["type"]
    assert_equal :youtube, result["provider"]
    assert_not_nil result["youtube_id"]
  end

  def test_transform_url_without_www
    result = auto_html('http://youtube.com/watch?v=tjYPasLKZN0') { youtube }
    assert_equal :video, result["type"]
    assert_equal :youtube, result["provider"]
    assert_not_nil result["youtube_id"]
  end

  def test_transform_with_options
    result = auto_html('http://www.youtube.com/watch?v=tjYPasLKZN0') { youtube(:width => 300, :height => 255, :frameborder => 1) }
    assert_equal :video, result["type"]
    assert_equal :youtube, result["provider"]
    assert_not_nil result["youtube_id"]
  end
  
end
