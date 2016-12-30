namespace :build do
  task :device => 'swifty:build_device'
  task :simulator => 'swifty:build_sim'
end

namespace :clean do
  task :all => 'swifty:clean'
end

namespace :swifty do
  desc 'Download and build dependencies'
  task :install do
    App.config.swifty.setup
  end

  task :build_sim do
    App.config.swifty.configure_platform("iPhoneSimulator")
  end
  task :build_device do
    App.config.swifty.configure_platform("iPhoneOS")
  end

  task :clean do
    paths = ["./vendor/Carts", "./Carthage", "Cartfile"]
    paths.each do |path|
      if File.exist?(path)
        App.info('Delete', path)
        rm_rf path
      end
    end
    App.info('Info', 'You will need to run `rake swifty:install` to reinstall your swift dependencies')
  end
end
