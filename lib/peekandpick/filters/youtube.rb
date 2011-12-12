require 'rubygems'
require 'nokogiri'
require 'open-uri'

youtube_lambda = lambda { |text, options|
  regex = /http:\/\/(www.)?youtube\.com\/watch\?v=([A-Za-z0-9._%-]*)(\&\S+)?|http:\/\/(www.)?youtu\.be\/([A-Za-z0-9._%-]*)?/
  text.gsub(regex) do |match|
    youtube_id = $2 || $5
    width = options[:width]
    height = options[:height]
    frameborder = options[:frameborder]
    result = Hash.new
    result['type'] = :video
    result['provider'] = :youtube
    #scrape the meta data 
    doc = Nokogiri::HTML(open(match))
    posts = doc.xpath("//meta")
    posts.each do |link|
      if link.attributes['name'].to_s == 'description'
        result['description'] = link.attributes['content'].to_s
      end
    end
    result['value'] = %{<iframe class="youtube-player" type="text/html" width="#{width}" height="#{height}" src="http://www.youtube.com/embed/#{youtube_id}" frameborder="#{frameborder}"></iframe>}
    return result
  end
}

PeekAndPick.add_filter(:youtube).with({:width => 390, :height => 250, :frameborder => 0}, youtube_lambda) 

