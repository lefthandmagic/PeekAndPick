require File.expand_path('../../unit_test_helper', __FILE__)

class DailyMotionTest < Test::Unit::TestCase

  def test_transform
    result = auto_html("http://www.dailymotion.com/en/featured/video/xag4p2_tempsmorttv-episode-01_shortfilms") { dailymotion }
    assert_equal :video, result["type"]
    assert_equal :dailymotion, result["provider"]
  end

  def test_transform_with_tweaked_width
    result = auto_html("http://www.dailymotion.com/video/xhr6l3") { dailymotion :width => 500 }
     assert_equal :video, result["type"]
     assert_equal :dailymotion, result["provider"]
  end

  def test_transform_with_options
    result = auto_html("http://www.dailymotion.com/video/xlvfkd") { dailymotion(:width => 500, :height => 300) }
    assert_equal :video, result["type"]
    assert_equal :dailymotion, result["provider"]
  end

end