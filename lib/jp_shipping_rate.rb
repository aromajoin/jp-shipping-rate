# frozen_string_literal: true

# external modules
require 'singleton'
require "yaml"

require_relative "jp_shipping_rate/version"

#
# This is a singleton class provides interface API calculate EMS shipping rate from Japan.
# There are several basic functions such as look-up international shipping rate,
# domestic shipping rate, look-up region of a country, japan's area of a prefecture.
#
# Usage:
# shipping_rate = JPShippingRate.instance
# shipping_rate.international(1500, "US")
# => 8500
# or 
#
# Note: Just support domestic from Kyoto for now.
# shipping_rate.domestic(140, "okinawa") 
# => 3200
#
class JPShippingRate
  include Singleton

  def initialize
    @rates = load_shipping_rates
    @regions = load_regions
    @jp_areas = load_domestic_areas
  end

  # For internaltion shipping (EMS):
  # 1. How much weight of the parcel?
  # 2. Identify country region from country code of destination
  # 3. Look up the shipping rate for weight and region
  # 4. plus base extra charges for internaltional shipping and insurrance charge?
  def international(weight, to_country_code)
    region = region_of_country(to_country_code)
    rate = 0
    rate += international_rate(weight, region) if weight > 0
    rate += international_extra_charges
  end

  # For domestic shipping:
  # 1. default size = 120 for now, parcel size is total of length, width and height
  # 2. state of destination is in lowercase format, e.g. kyoto, tokyo, osaka
  # 3. calculate cost with given size and state
  # 4. plus extra charges for domestic shipping and insurrance charge?
  def domestic(size = 120, to_state)
    area = area_of_prefecture(to_state)
    rate = 0
    rate += domestic_rate(size, area) if size > 0
    rate += domestic_extra_charges
  end

  # Find region of the country
  # with given country code from the order info.
  def region_of_country(country_code = "JP")
    result = @regions["asia"].to_s
    @regions.each do |region, countries|
      countries.each do |country|
        if country[country_code] != nil
          return result = region.to_s
        end
      end
    end
  rescue NoMethodError
    return "asia"
  end

  # Find domestic area of Japan's states
  # Such as: Hokkaido, Kanto, Okinawa, ...
  def area_of_prefecture(state_name = "kyoto")
    result = "okinawa"
    @jp_areas.each do |area, states|
      states.each do |state|
        if state[state_name] != nil
          return result = area.to_s
        end
      end
    end
  rescue NoMethodError
    return "hokkaido"
  end

  # Calculate an extra charge for internation EMS
  # with a base extra charge and insurrance condition?
  def international_extra_charges(base = 3_500, insurrance = false)
    extra = base
    extra += 3_000 if insurrance
    extra
  end

  # Calculate an extra charge for domestic shipping
  # with a base extra charge and insurrance condition?
  def domestic_extra_charges(base = 850, insurrance = false)
    extra = base
    extra += 1_000 if insurrance
    extra
  end

  # Calculate EMS rate with given params
  # @param: weight::Integer - Weight of the parcel.
  # @param: region::String - Regions that is defined by Japan Post service
  def international_rate(weight, region)
    rate = 0
    @rates["international_ems"].each do |w, r|
      unless w.to_i < weight
        r.each do |r_rate|
          unless r_rate[region].nil?
            return rate = r_rate[region]
          end
        end
      end
    end
    rate
  end

  # Calculate domestic shipping rate with given params
  # @param size::Integer - size of total of length, width and height
  # @param area::String - Areas of Japan (Okinawa, Hokkaido, Kanto,...)
  def domestic_rate(size = 100, area = "okinawa")
    rate = 0
    @rates["domestic_parcel"].each do |w, r|
      unless w.to_i < size
        r.each do |r_rate|
          unless r_rate[area].nil?
            return rate = r_rate[area]
          end
        end
      end
    end
    rate
  end

  private

    def root_path
      File.expand_path '../..', __FILE__
    end

    # Load data of EMS shipping rates
    def load_shipping_rates
      YAML.load_file("#{root_path}/config/rates.yml")
    end

    # Load data of region of countries
    def load_regions
      YAML.load_file("#{root_path}/config/countries.yml")
    end

    # Load Japan areas
    def load_domestic_areas
      YAML.load_file("#{root_path}/config/japan_areas.yml")
    end
end