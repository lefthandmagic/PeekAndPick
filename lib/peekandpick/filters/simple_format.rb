require 'action_view'


simple_format_lambda = lambda { |text, html_options|
  args = [text, {}, {:sanitize => false}]
  begin
    ActionView::Base.new.simple_format(*args) 
  rescue ArgumentError
    # Rails 2 support
    args.pop
    retry
  end
}

PeekAndPick.add_filter(:simple_format).with({}, simple_format_lambda) 