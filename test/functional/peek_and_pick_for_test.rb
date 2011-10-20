require File.expand_path('../../test_helper', __FILE__)
require File.expand_path('../../fixture_setup', __FILE__)

class Article < ActiveRecord::Base
  peek_and_pick_for :body do
    #html_escape
    youtube(:width => 400, :height => 250)
    image
    #link(:target => "_blank")
    #simple_format
  end
end

class PeekAndPickForTest < Test::Unit::TestCase
  include FixtureSetup

  def test_transform_on_initialization
    @article = Article.new(:body => 'Do you like this logo http://rors.org/images/rails.png? Yeah?')
    puts @article.body_html
    assert_equal '<p>Yo!</p>', @article.body_html
  end

  def test_html_safe
    return unless "".respond_to?(:html_safe?)
    @article = Article.new(:body => 'http://www.youtube.com/watch?v=BwNrmYRiX_o&feature=related')
    puts @article.body_html
    assert @article.body_html.html_safe?
  end

  def test_transform_after_save
    @article = Article.new(:body => 'Yo!')
    @article.save!
    assert_equal '<p>Yo!</p>', @article.body_html
  end

  def test_transform_of_nil
    @article = Article.new(:body => nil)
    @article.save!
    assert_equal '', @article.body_html
  end

  def test_transform_after_update
    @article = Article.create!(:body => 'Yo!')
    @article.update_attributes(:body => 'http://vukajlija.com')
    @article.save!
    assert_equal '<p><a href="http://vukajlija.com" target="_blank">http://vukajlija.com</a></p>', @article.body_html
  end
end