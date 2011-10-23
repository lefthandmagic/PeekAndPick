require 'rubygems'
require 'nokogiri'
require 'open-uri'

dailymotion_lambda = lambda { |text, options|
  text.gsub(/http:\/\/www\.dailymotion\.com.*\/video\/(.+)_*/) do |match|
    video_id = $1
    result = Hash.new
    result['type'] = 'video'
    #scrape the meta data 
    doc = Nokogiri::HTML(open(match))
    posts = doc.xpath("//meta")
    posts.each do |link|
      if link.attributes['name'].to_s == 'description'
        result['description'] = link.attributes['content'].to_s
      end
    end
    result['value'] = %{<object type="application/x-shockwave-flash" data="http://www.dailymotion.com/swf/#{video_id}&related=0" width="#{options[:width]}" height="#{options[:height]}"><param name="movie" value="http://www.dailymotion.com/swf/#{video_id}&related=0"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><a href="http://www.dailymotion.com/video/#{video_id}?embed=1"><img src="http://www.dailymotion.com/thumbnail/video/#{video_id}" width="#{options[:width]}" height="#{options[:height]}"/></a></object>}
    return result
  end
}

PeekAndPick.add_filter(:dailymotion).with({:width => 480, :height => 360}, dailymotion_lambda)
