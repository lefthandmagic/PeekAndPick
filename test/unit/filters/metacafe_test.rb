require File.expand_path('../../unit_test_helper', __FILE__)

class MetaCafeTest < Test::Unit::TestCase

  def test_transform
    result = auto_html("http://www.metacafe.com/watch/5440707/exclusive_tron_evolution_dev_diary_the_art_design") { metacafe }
    assert_equal :video, result["type"]
    assert_equal :metacafe, result["provider"]
  end

  def test_transform_with_dimensions
    result = auto_html("http://www.metacafe.com/watch/5440707/exclusive_tron_evolution_dev_diary_the_art_design") { metacafe(:width => 500, :height => 300) }
    assert_equal :video, result["type"]
    assert_equal :metacafe, result["provider"]
  end

  def test_transform_with_show_stats
    result = auto_html("http://www.metacafe.com/watch/5440707/exclusive_tron_evolution_dev_diary_the_art_design") { metacafe(:width => 500, :height => 300, :show_stats => true) }
    assert_equal :video, result["type"]
    assert_equal :metacafe, result["provider"]
 end

  def test_transform_with_autoplay
    result = auto_html("http://www.metacafe.com/watch/5440707/exclusive_tron_evolution_dev_diary_the_art_design") { metacafe(:width => 500, :height => 300, :autoplay => true) }
    assert_equal :video, result["type"]
    assert_equal :metacafe, result["provider"]
  end

  def test_transform_with_options
    result = auto_html("http://www.metacafe.com/watch/5440707/exclusive_tron_evolution_dev_diary_the_art_design") { metacafe(:width => 500, :height => 300, :show_stats => true, :autoplay => true) }
    assert_equal :video, result["type"]
    assert_equal :metacafe, result["provider"]
  end
end