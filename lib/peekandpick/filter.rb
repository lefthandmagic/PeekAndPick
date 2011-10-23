module PeekAndPick
  class Filter
    def initialize(block)
      @block = block
      @options = nil
    end

    def with(options, block)
      @options = options
      @block = block
    end

    def apply(text, options = {})
      text = (text.nil?)? text.to_s : text
      _options = @options && @options.merge(options)
      if _options
        @block.call(text.dup, _options)
      else
        @block.call(text.dup)
      end
    end
  end
end