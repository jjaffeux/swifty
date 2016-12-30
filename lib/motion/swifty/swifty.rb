module MotionSwifty
  class Swifty
    attr_reader :config
    attr_accessor :carts

    def initialize(config)
      @config = config
      @carts = []
    end

    def cartfile(&block)
      self.instance_eval(&block)
    end

    def cart(cart, options = {})
      @carts << Cart.new(cart, options)
    end

    def setup
      generate_cartfile(self.carts)
      pull_frameworks(carthage_platform(config.template))
      copy_frameworks(self.config.archs, self.carts)
    end

    def configure_platform(platform)
      frameworks = File.join(self.config.app_bundle(platform), "Frameworks")
      update_swift_dlybs("./Cartfile", frameworks) do
        clean_swift_dlybs(frameworks)
        copy_swift_dlybs(platform, frameworks)
      end

      self.config.embedded_frameworks += self.carts.map(&:path)
    end

    private

    def update_swift_dlybs(cartfile, frameworks, &block)
      lib_swift = Dir.glob(File.join(frameworks, '**/libswiftCore.dylib')).first
      if !lib_swift || !File.exists?(lib_swift) || File.mtime(cartfile) > File.mtime(lib_swift)
        block.call
      end
    end

    def pull_frameworks(carthage_platform)
      `carthage update --platform #{carthage_platform} --no-use-binaries`
    end

    def copy_frameworks(archs, carts)
      ENV["TARGET_BUILD_DIR"] = File.expand_path("./vendor/Carts")
      ENV["BUILT_PRODUCTS_DIR"] = File.expand_path("./vendor/Carts")

      archs.each do |platform, platform_archs|
        ENV["SCRIPT_INPUT_FILE_COUNT"] = carts.count.to_s
        ENV["FRAMEWORKS_FOLDER_PATH"] = platform_archs.join(" ")
        ENV["VALID_ARCHS"] = platform_archs.join(" ")

        carts.each_with_index do |cart, index|
          ENV["SCRIPT_INPUT_FILE_#{index}"] = cart.path
        end

        `carthage copy-frameworks`
      end
    end

    def clean_swift_dlybs(dlybs_folder)
      FileUtils.rm(Dir.glob(File.join(dlybs_folder, '**/libswift*.dylib')))
    end

    def carthage_platform(platform)
      case platform
      when :ios
        "iOS"
      else
        "all"
      end
    end

    def generate_cartfile(carts)
      target = File.open("Cartfile", 'w+')
      target.write(carts.map(&:definition).join("\r\n"))
      target.close
    end

    def copy_swift_dlybs(platform, frameworks_path)
      swift_stdlib_tool = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-stdlib-tool"
      archs = self.config.archs[platform].join(' ')
      folder = Shellwords.escape("./vendor/Carts/#{archs}")
      frameworks_path = Shellwords.escape(frameworks_path)
      `#{swift_stdlib_tool} --copy --scan-folder #{folder} --platform #{platform.downcase} --destination #{frameworks_path}`
    end
  end
end
