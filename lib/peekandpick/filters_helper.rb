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
  
  # if result type is link, and it doesn't have a og image
  # then get all images greater than certain size
  if result['type'] == :link && !og['og:image']
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
    if !img_src.starts_with? 'http://'
      if img_src.starts_with? '/'
        img_src = base_uri + img_src 
      else
        img_src = base_uri + '/' + img_src 
      end
    end
    images_set.add(img_src)
  end

  #filter each of these for sizes 
  result_set = Set.new
  minWidth = options[:width]
  minWidth ||= 120
  minHeight ||= 100
  images_set.each do |img_src|
    size = FastImage.size(img_src)
    if size && size[0] > minWidth && size[1] > minHeight
      result_set.add(img_src)
    end
  end
  return result_set 
end