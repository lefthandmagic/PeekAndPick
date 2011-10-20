
%w(base filter builder peek_and_pick_for).each do |f|
  require File.expand_path("../peekandpick/#{f}", __FILE__)
end
  
Dir["#{File.dirname(__FILE__) + '/peekandpick/filters'}/**/*"].each do |filter|
  require "#{filter}"
end
  
# if rails
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, PeekAndPickFor

  module ActionView::Helpers::TextHelper
    include PeekAndPick
  end
end
