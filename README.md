# Swifty

A simple and clean way to use Swift dependencies in your RubyMotion project.


## Setup

- brew install carthage
- brew install swiftlint
- add 'motion-swifty' to your Gemfile
- bundle install

Define your dependencies inside your Rakefile:

```ruby
###
app.cartfile do
  cart 'github "nickoneill/PermissionScope" "master"'
  cart '"file:///directory/to/project" "branch"', name: "MyFramework"
end
```

- rake swifty:install
- rake


## Todo

- Support other platforms than iOS, if you need it please open an issue


## Thanks

Thanks to [Mark Villacampa](https://twitter.com/MarkVillacampa) who did all the hard work in RubyMotion to make this possible.
