require_relative '../filters_helper'

dailymotion_lambda = lambda { |text, options|
  text.gsub(/http:\/\/www\.dailymotion\.com.*\/video\/(.+)_*/) do |match|
    video_id = $1
    result = Hash.new
    result['type'] = :video
    result['provider'] = :dailymotion
    result['video_url'] = match
    result['dailymotion_id'] = video_id
    #scrape the meta data 
    doc = Nokogiri::HTML(open(match))
    posts = doc.xpath("//meta")
    scrape_page(posts, result)
    return result
  end
}

PeekAndPick.add_filter(:dailymotion).with({:width => 480, :height => 360}, dailymotion_lambda)
