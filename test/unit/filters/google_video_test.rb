require File.expand_path('../../unit_test_helper', __FILE__)

class GoogleVideoTest < Test::Unit::TestCase

  def test_transform
    result = auto_html("http://video.google.com/videoplay?docid=7442132741322615356") { google_video }
     assert_equal :video, result["type"]
     assert_equal :google_video, result["provider"]
end

  def test_transform_with_options
    result = auto_html("http://video.google.com/videoplay?docid=7442132741322615356") { google_video(:width => 500, :height => 300) }
    assert_equal :video, result["type"]
    assert_equal :google_video, result["provider"]  
  end

end