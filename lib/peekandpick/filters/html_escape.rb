html_escape_lambda = lambda { |text, options|
  text.to_s.gsub(/[&"><]/) { |special| options[:map][special] }
}


PeekAndPick.add_filter(:html_escape).with({
  :map => { 
    '&' => '&amp;',  
    '>' => '&gt;',
    '<' => '&lt;',
    '"' => '&quot;' }}, html_escape_lambda) 