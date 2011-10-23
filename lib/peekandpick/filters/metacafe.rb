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
    result['type'] = 'video'
    #scrape the meta data 
    doc = Nokogiri::HTML(open(match))
    posts = doc.xpath("//meta")
    posts.each do |link|
      if link.attributes['name'].to_s == 'description'
        result['description'] = link.attributes['content'].to_s
      end
    end
    result['value'] = %{<div style="background:#000000;width:#{width}px;height:#{height}px"><embed flashVars="playerVars=#{flash_vars}" src="http://www.metacafe.com/fplayer/#{metacafe_id}/#{metacafe_slug}.swf" width="#{width}" height="#{height}" wmode="transparent" allowFullScreen="true" allowScriptAccess="always" name="Metacafe_#{metacafe_id}" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"></embed></div>}
    return result
  end
}


PeekAndPick.add_filter(:metacafe).with({:width => 440, :height => 272, :show_stats => false, :autoplay => false}, metacafe_lambda)