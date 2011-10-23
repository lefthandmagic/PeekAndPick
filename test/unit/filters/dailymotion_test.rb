require File.expand_path('../../unit_test_helper', __FILE__)

class DailyMotionTest < Test::Unit::TestCase

  def test_transform
    result = auto_html("http://www.dailymotion.com/en/featured/video/xag4p2_tempsmorttv-episode-01_shortfilms") { dailymotion }
    assert_equal '<object type="application/x-shockwave-flash" data="http://www.dailymotion.com/swf/xag4p2_tempsmorttv-episode-01_shortfilms&related=0" width="480" height="360"><param name="movie" value="http://www.dailymotion.com/swf/xag4p2_tempsmorttv-episode-01_shortfilms&related=0"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><a href="http://www.dailymotion.com/video/xag4p2_tempsmorttv-episode-01_shortfilms?embed=1"><img src="http://www.dailymotion.com/thumbnail/video/xag4p2_tempsmorttv-episode-01_shortfilms" width="480" height="360"/></a></object>', result['value']
  end

  def test_transform_with_tweaked_width
    result = auto_html("http://www.dailymotion.com/video/xhr6l3") { dailymotion :width => 500 }
    assert_equal '<object type="application/x-shockwave-flash" data="http://www.dailymotion.com/swf/xhr6l3&related=0" width="500" height="360"><param name="movie" value="http://www.dailymotion.com/swf/xhr6l3&related=0"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><a href="http://www.dailymotion.com/video/xhr6l3?embed=1"><img src="http://www.dailymotion.com/thumbnail/video/xhr6l3" width="500" height="360"/></a></object>', result['value']
  end

  def test_transform_with_options
    result = auto_html("http://www.dailymotion.com/video/xlvfkd") { dailymotion(:width => 500, :height => 300) }
    assert_equal '<object type="application/x-shockwave-flash" data="http://www.dailymotion.com/swf/xlvfkd&related=0" width="500" height="300"><param name="movie" value="http://www.dailymotion.com/swf/xlvfkd&related=0"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><a href="http://www.dailymotion.com/video/xlvfkd?embed=1"><img src="http://www.dailymotion.com/thumbnail/video/xlvfkd" width="500" height="300"/></a></object>', result['value']
  end

end