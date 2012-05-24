require 'rinku'
require 'tag_helper'
require_relative '../filters_helper'


link_lambda = lambda { |text, options|
  
  rinkuResult = Rinku.auto_link(text, :all, TagHelper.attributes(options))
  htmldoc = Nokogiri::HTML(rinkuResult)
  links = htmldoc.css('a')
  if !links.blank? 
    hrefs = links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if {|href| href.empty?}
    result = Hash.new
    result['type'] = :link
    result['value'] = rinkuResult
    scrape_page(hrefs[0], result, options)
    return result
  else
    return rinkuResult
  end
}


PeekAndPick.add_filter(:link).with({}, link_lambda)