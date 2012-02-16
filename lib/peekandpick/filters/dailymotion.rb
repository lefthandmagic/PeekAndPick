require 'rubygems'
require 'nokogiri'
require 'open-uri'

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
    posts.each do |link|
      if link.attributes['name'].to_s == 'description'
        result['description'] = link.attributes['content'].to_s
      end
    end
    return result
  end
}

PeekAndPick.add_filter(:dailymotion).with({:width => 480, :height => 360}, dailymotion_lambda)
