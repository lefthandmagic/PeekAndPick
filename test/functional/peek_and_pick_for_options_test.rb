require File.expand_path('../../test_helper', __FILE__)
require File.expand_path('../../fixture_setup', __FILE__)

# store default so we can revert so that other tests use default option
default_suffix = PeekAndPickFor.peek_and_pick_for_options[:htmlized_attribute_suffix]
PeekAndPickFor.peek_and_pick_for_options[:htmlized_attribute_suffix] = '_htmlized'

class Article < ActiveRecord::Base
  peek_and_pick_for :body do
    simple_format
  end
end

class PeekAndPickForOptionsTest < Test::Unit::TestCase
  include FixtureSetup

  def test_transform_after_save
    @article = Article.new(:body => 'Yo!')
    assert_equal '<p>Yo!</p>', @article.body_htmlized['value']
    @article.save!
    assert_equal '<p>Yo!</p>', @article.body_htmlized['value']
  end
end

# reverting to default so that other tests use default option
PeekAndPickFor.peek_and_pick_for_options[:htmlized_attribute_suffix] = default_suffix