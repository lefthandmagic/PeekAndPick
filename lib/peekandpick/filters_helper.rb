require 'open-uri'
require 'nokogiri'
require 'fastimage'

def scrape_page(match, result, options = {})
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
  title = doc.css('title').first if result['title'].nil?
  result['title'] = title.content if title 
  result['og'] = og
  
  # if result type is link, get all images greater than certain size
  if result['type'] = :link
    images = get_images_array(doc, match, options)
    result['images'] = images
  end
  
  return result
end

def get_images_array(doc, match, options)
  #images_set is used to remove duplicates
  images_set = Set.new
  uri = URI.parse(match)
  base_uri = "#{uri.scheme}://#{uri.host}"
  img_tags = doc.xpath("//img")
  
  # create images set eliminating duplicates
  img_tags.each do |img_tag|
    img_src = img_tag.attributes['src'].to_s
    img_src = base_uri + img_src if img_src.starts_with? '/'
    images_set.add(img_src)
  end
  
  #filter each of these for sizes 
  result_set = Set.new
  minWidth = options[:width]
  minWidth ||= 120
  images_set.each do |img_src|
    size = FastImage.size(img_src)
    if size && size[0] > minWidth
      result_set.add(img_src)
    end
  end
  return result_set 
end