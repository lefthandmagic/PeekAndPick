module PeekAndPickFor

  # default options that can be overridden on the global level
  @@auto_html_for_options = {
    :htmlized_attribute_suffix => '_html'
  }
  mattr_reader :auto_html_for_options

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def auto_html_for(raw_attrs, &proc)
      include PeekAndPickFor::InstanceMethods
      before_save :auto_html_prepare

      define_method("auto_html_prepare") do
        auto_html_methods = self.methods.select { |m| m=~/^auto_html_prepare_/ }
        auto_html_methods.each do |method|
          self.send(method)
        end
      end

      suffix =  PeekAndPickFor.auto_html_for_options[:htmlized_attribute_suffix]

      [raw_attrs].flatten.each do |raw_attr|
        define_method("#{raw_attr}#{suffix}=") do |val|
          write_attribute("#{raw_attr}#{suffix}", val)
        end
        define_method("#{raw_attr}#{suffix}") do
          result = read_attribute("#{raw_attr}#{suffix}") || send("auto_html_prepare_#{raw_attr}")
          result.respond_to?(:html_safe) ?
            result.html_safe :
              result
        end
        define_method("auto_html_prepare_#{raw_attr}") do
          self.send(raw_attr.to_s + suffix + "=", 
            auto_html(self.send(raw_attr), &proc))
        end
      end
    end
  end

  module InstanceMethods
    include PeekAndPick
  end
end