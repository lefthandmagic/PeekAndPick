require 'rinku'
require 'tag_helper'
require 'nokogiri'
require 'open-uri'

link_lambda = lambda { |text, options|
  
  
  rinkuResult = Rinku.auto_link(text, :all, TagHelper.attributes(options))
  htmldoc = Nokogiri::HTML(rinkuResult)
  links = htmldoc.css('a')
  if !links.blank? 
    hrefs = links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if {|href| href.empty?}
    doc = Nokogiri::HTML(open(hrefs[0]))
    posts = doc.xpath("//meta")
    result = Hash.new
    result['type'] = :link
    result['value'] = rinkuResult
    posts.each do |link|
      if link.attributes['name'].to_s == 'description'
        result['description'] = link.attributes['content'].to_s
      end
    end
    return result
  else
    return rinkuResult
  end
}


PeekAndPick.add_filter(:link).with({}, link_lambda)