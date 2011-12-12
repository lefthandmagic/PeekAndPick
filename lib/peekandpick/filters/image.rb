image_lambda = lambda { |text, options|
  text.gsub(/https?:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
    result = Hash.new
    result['type'] = :image
    result['value'] = match
    return result
  end
}

PeekAndPick.add_filter(:image).with({:alt => ''}, image_lambda)
