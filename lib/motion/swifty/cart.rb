module MotionSwifty
  class Cart
    attr_accessor :definition
    attr_accessor :options

    def initialize(definition, options = {})
      @definition = definition
      @options = options
    end

    def name
      self.options.fetch(:name) do
        if match = @definition.match(/.* ".*\/(.*?)"/i)
          match.captures.first
        else
          raise "Couldn’t extract cart name from its Cartfile definition"
        end
      end
    end

    def path(plaform = "iOS")
      File.expand_path("./Carthage/Build/#{plaform}/#{name}.framework")
    end
  end
end
