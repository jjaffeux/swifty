unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

if Motion::Project::App.template != :ios
  fail('This file must be required within a RubyMotion iOS project.')
end

module Motion::Project
  class Config
    variable :swifty

    def swifty
      @swifty ||= MotionSwifty::Swifty.new(self)
    end

    def cartfile(&block)
      swifty.instance_eval(&block) if block
    end
  end
end
