require_relative '../filters_helper'

google_video_lambda = lambda { |text, options|
  text.gsub(/http:\/\/video\.google\.com\/videoplay\?docid\=(-?[0-9]*)[&\w;=\+_\-]*/) do |match|
    docid = $1
    result = Hash.new
    result['type'] = :video
    result['provider'] = :google_video
    result['video_url'] = match
    result['google_video_id'] = docid
    #scrape the meta data 
    doc = Nokogiri::HTML(open(match))
    posts = doc.xpath("//meta")
    scrape_page(posts, result)
    return result
  end
}

PeekAndPick.add_filter(:google_video).with({:width => 650, :height => 391}, google_video_lambda)