
  
%w(base filter builder peek_and_pick_for).each do |f|
  require File.expand_path("../peekandpick/#{f}", __FILE__)
end
  
Dir["#{File.dirname(__FILE__) + '/peekandpick/filters'}/**/*"].each do |filter|
  require "#{filter}"
end
  

