require File.expand_path('../unit_test_helper', __FILE__)


class AutoHtmlTest < Test::Unit::TestCase

  def test_should_be_raw_input_when_no_filters_provided
    input = "Hey check out my blog => http://rors.org"
    result = auto_html(input) { }
    assert_equal result, input
  end

  def test_should_return_blank_if_input_is_blank
    result = auto_html("") { image(:alt => nil); }
    assert_equal "", result
  end
  
  def test_should_not_apply_simple_format_if_input_is_nil
    result = auto_html(nil) { image(:alt => nil); }
    assert_equal "", result
  end

end