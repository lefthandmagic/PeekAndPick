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
    return result
  end
}

PeekAndPick.add_filter(:google_video).with({:width => 650, :height => 391}, google_video_lambda)