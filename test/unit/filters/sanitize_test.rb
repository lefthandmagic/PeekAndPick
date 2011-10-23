require File.expand_path('../../unit_test_helper', __FILE__)

class SanitizeTest < Test::Unit::TestCase

  def test_trasform
    result = auto_html("<script>alert(0)</script>") { sanitize }
    assert_equal "", result['value']
  end

  def test_trasform2
    result = auto_html("<div>test</div>") { sanitize }
    assert_equal "<div>test</div>", result['value']
  end

  def test_trasform3
    result = auto_html("<div>test</div>") { sanitize :tags => %w(div) }
    assert_equal "<div>test</div>", result['value']
  end

  def test_trasform4
    result = auto_html("<div>test</div>") { sanitize :tags => %w(p) }
    assert_equal "test", result['value']
  end

  def test_trasform5
    result = auto_html("<a rel='nofollow'>test</div>") { sanitize :tags => %w(a), :attributes => %w(href)}
    assert_equal "<a>test", result['value']
    #
    # from Rails doc:
    #
    #   Please note that sanitizing user-provided text does not 
    #   guarantee that the resulting markup is valid.
    #
  end

end