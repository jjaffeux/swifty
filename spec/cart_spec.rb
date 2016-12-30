require File.expand_path('../spec_helper', __FILE__)

describe 'MotionSwifty::Cart' do
  it '#name' do
    @subject = MotionSwifty::Cart.new('github "SwiftyJSON/SwiftyJSON"')
    @subject.name.should == "SwiftyJSON"

    @subject = MotionSwifty::Cart.new('github "nickoneill/PermissionScope" "master"')
    @subject.name.should == "PermissionScope"

    @subject = MotionSwifty::Cart.new('cart "file:///directory/to/project" "branch"', name: "MyFramework")
    @subject.name.should == "MyFramework"
  end

  it '#path' do
    @subject = MotionSwifty::Cart.new('github "SwiftyJSON/SwiftyJSON"')
    @subject.path.should == File.expand_path("./Carthage/Build/iOS/SwiftyJSON.framework")
  end
end
