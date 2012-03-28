def scrape_page(match, result)
  doc = Nokogiri::HTML(open(match))
  posts = doc.xpath("//meta")
  og = Hash.new
  posts.each do |link|
    if link.attributes['name'].to_s == 'description'
      result['description'] = link.attributes['content'].to_s
    elsif link.attributes['name'].to_s == 'title'
      result['title'] = link.attributes['content'].to_s
    elsif link.attributes['property'].to_s.start_with?("og:")
      og[link.attributes['property'].to_s] = link.attributes['content'].to_s
    end
  end
  result['title'] = doc.css('title') if result['title'].nil?
  result['og'] = og
  return result
end