require_relative '../filters_helper'

vimeo_lambda = lambda { |text, options|
  text.gsub(/http:\/\/(www.)?vimeo\.com\/([A-Za-z0-9._%-]*)((\?|#)\S+)?/) do |match|
    vimeo_id = $2
    width  = options[:width]
    height = options[:height]
    show_title      = "title=0"    unless options[:show_title]
    show_byline     = "byline=0"   unless options[:show_byline]  
    show_portrait   = "portrait=0" unless options[:show_portrait]
    frameborder     = options[:frameborder] || 0
    query_string_variables = [show_title, show_byline, show_portrait].compact.join("&")
    query_string    = "?" + query_string_variables unless query_string_variables.empty?
    result = Hash.new
    result['type'] = :video
    result['provider'] = :vimeo
    result['video_url'] = match
    result['vimeo_id'] = vimeo_id
    #scrape the meta data 
    doc = Nokogiri::HTML(open(match))
    posts = doc.xpath("//meta")
    scrape_page(posts, result)
    return result
  end
}


PeekAndPick.add_filter(:vimeo).with({:width => 440, :height => 248, :show_title => false, :show_byline => false, :show_portrait => false}, vimeo_lambda)