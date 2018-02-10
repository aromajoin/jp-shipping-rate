# JPShippingRate

A Ruby gem provides look-up and calculations tool for Japan Shipping Rate.

At present, it supports international and domestic shipping methods:

* With international shipping method is EMS fee.
* With domestic (inside Japan) is Yu-Pack method, only support calculating for Kyoto deposite now.

## Installation

If you are in Rails, add this line to your application's Gemfile:

```ruby
gem 'JPShippingCost'
```

And then execute:

    $bundle

Or install it yourself as:

    $gem install jp-shipping-rate

## Usage


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aromajoin/jp-shipping-rate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the JPShippingRate project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aromajoin/jp-shipping-rate/blob/master/CODE_OF_CONDUCT.md).

## LICENSE

JPShippingRate is released under the [Apache License](/LICENSE).
