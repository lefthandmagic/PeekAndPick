require 'action_controller'
require 'cgi'

sanitize_lambda = lambda { |text, options|
  if (text.instance_of? Hash)
    text['value'] = HTML::WhiteListSanitizer.new.sanitize(text['value'], options)
  else
    sanitizedText =  HTML::WhiteListSanitizer.new.sanitize(text, options)
    text = Hash.new
    text['value'] = sanitizedText
  end
  return text
}

PeekAndPick.add_filter(:sanitize).with({}, sanitize_lambda) 