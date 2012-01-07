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
    posts.each do |link|
      if link.attributes['name'].to_s == 'description'
        result['description'] = link.attributes['content'].to_s
      end
    end
    result['value'] = %{<object width="#{options[:width]}" height="#{options[:height]}"><param name="movie" value="http://video.google.com/googleplayer.swf?docid=#{docid}&hl=en&fs=true"></param><param name="wmode" value="transparent"></param><embed src="http://video.google.com/googleplayer.swf?docid=#{docid}" type="application/x-shockwave-flash" wmode="transparent" width="#{options[:width]}" height="#{options[:height]}"></embed></object>}
    return result
  end
}

PeekAndPick.add_filter(:google_video).with({:width => 650, :height => 391}, google_video_lambda)