require File.expand_path('../../unit_test_helper', __FILE__)

class VimeoTest < Test::Unit::TestCase

  def test_transform_url_with_www
    result = auto_html('http://www.vimeo.com/3300155') { vimeo }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

  def test_transform_url_without_www
    result = auto_html('http://vimeo.com/3300155') { vimeo }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

  def test_transform_url_with_params
    result = auto_html('http://vimeo.com/3300155?pg=embed&sec=') { vimeo }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

  def test_transform_url_with_anchor
    result = auto_html('http://vimeo.com/3300155#skirt') { vimeo }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

  def test_transform_with_options
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250) }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

  def test_transform_with_title
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250, :show_title => true) }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

  def test_transform_with_byline
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250, :show_byline => true) }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

  def test_transform_with_portrait
    result = auto_html("http://www.vimeo.com/3300155") { vimeo(:width => 300, :height => 250, :show_portrait => true) }
    assert_equal :video, result["type"]
    assert_equal :vimeo, result["provider"]
  end

end