require 'action_view'


simple_format_lambda = lambda { |text, html_options|
  args = [((text.instance_of? Hash)? text['value'] : text), {}, {:sanitize => false}]
  begin    
  if (text.instance_of? Hash)
    text['value'] = ActionView::Base.new.simple_format(*args) 
  else
    text = Hash.new
    text['type'] = 'default'
    text['value'] = ActionView::Base.new.simple_format(*args) 
  end
  return text
  rescue ArgumentError
    # Rails 2 support
    args.pop
    retry
  end
}

PeekAndPick.add_filter(:simple_format).with({}, simple_format_lambda) 