require_relative '../filters_helper'

youtube_lambda = lambda { |text, options|
  regex = /http(s)?:\/\/(www.)?youtube\.com\/watch\?(.)*v=([A-Za-z0-9._%-]*)(\&\S+)?|http(s)?:\/\/(www.)?youtu\.be\/([A-Za-z0-9._%-]*)(\&\S+)?/
  text.gsub(regex) do |match|
    youtube_id = $4 || $8
    width = options[:width]
    height = options[:height]
    frameborder = options[:frameborder]
    result = Hash.new
    result['type'] = :video
    result['provider'] = :youtube
    result['video_url'] = match
    result['youtube_id'] = youtube_id
    #scrape the meta data 
    scrape_page(match, result)
    return result
  end
}

PeekAndPick.add_filter(:youtube).with({:width => 390, :height => 250, :frameborder => 0}, youtube_lambda) 

