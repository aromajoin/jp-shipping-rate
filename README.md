# JPShippingRate

A Ruby gem provides look-up and calculations tool for Japan Shipping Rate.

At present, it supports international and domestic shipping methods:

* With international shipping method is EMS fee = rate + extra charges.
* With domestic (inside Japan) is Yu-Pack fee = domestic rate + extra charges. Only support calculating fee for Kyoto deposite now.

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

### Instance

```Ruby
shipping_rate = JPShippingRate.instance
```

### Calculate EMS fee with extra charges (base charges + insurrance cost)

```Ruby
    shipping_rate.international(1500, "US")
    => 8500 # equivalent to 8500 yen
```

### Or calculate domestic Yu-pack fee with with extra charges (base charges + insurrance cost)

*Note: Just support domestic from Kyoto for now.*

```Ruby
    shipping_rate.domestic(140, "okinawa")
    # => 3200 (yen)
```

### Only look-up shipping rate

for EMS rate

```Ruby
    # weight = 3500 (g)
    # region = "asia"
    shipping_rate.international_rate(weight, region)
```

for JP domestic rate (Yu-pack)

```Ruby
    # size = 120 is total of length, width, height of parcel
    # destination_area = "okinawa" area is based on Japan post service definition.
    shipping_rate.domestic_rate(size, destination_area)
```

We also provides utility methods, please look at source codes.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aromajoin/jp-shipping-rate. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the JPShippingRate project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aromajoin/jp-shipping-rate/blob/master/CODE_OF_CONDUCT.md).

## LICENSE

JPShippingRate is released under the [Apache License](/LICENSE).
