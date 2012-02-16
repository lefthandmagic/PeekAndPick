metacafe_lambda = lambda { |text, options|
  text.gsub(/http:\/\/www\.metacafe\.com\/watch\/([A-Za-z0-9._%-]*)\/([A-Za-z0-9._%-]*)(\/)?/) do |match|
    metacafe_id = $1
    metacafe_slug = $2
    width  = options[:width]
    height = options[:height]
    show_stats      = options[:show_stats] ? "showStats=yes" : "showStats=no"
    autoplay        = options[:autoplay] ? "autoPlay=yes" : "autoPlay=no"
    flash_vars = [show_stats, autoplay].join("|")
    result = Hash.new
    result['type'] = :video
    result['provider'] = :metacafe
    result['video_url'] = match
    result['metacafe_id'] = metacafe_id
    result['metacafe_slug'] = metacafe_slug
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


PeekAndPick.add_filter(:metacafe).with({:width => 440, :height => 272, :show_stats => false, :autoplay => false}, metacafe_lambda)