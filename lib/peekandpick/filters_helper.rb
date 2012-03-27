def scrape_page(posts, result)
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
  result['og'] = og
  return result
end